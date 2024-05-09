resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "vpc")
  })
}

/* Public Subnet Creation */
resource "aws_subnet" "public_subnet" {
  count                   = var.public_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 1)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(var.tags, { "Name" = format("%s-%s-%s-%s", var.project, var.env, "public-subnet", count.index + 1) })
}

resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "public-igw") })
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_anywhere #"0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }
  tags = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "public-rt") })
}


resource "aws_route_table_association" "public_rt" {
  count          = var.public_subnet_count
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

# Private Subnet Creation

resource "aws_subnet" "private_subnet" {
  count                   = var.private_subnet_count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr_block, 8, count.index + 100)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = merge(var.tags, { "Name" = format("%s-%s-%s-%s", var.project, var.env, "private-subnet", count.index + 1) })
}


resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.public_igw]
  tags       = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "eip-nat") })
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public_subnet.*.id, 0)
  depends_on    = [aws_internet_gateway.public_igw]
  tags          = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "nat-gw") })
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.cidr_block_anywhere # "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "private-rt") })
}

resource "aws_route_table_association" "private_rt" {
  count          = var.private_subnet_count
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}