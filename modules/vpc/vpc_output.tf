output "public_subnets" {
  value = aws_subnet.public_subnet[0].id
}

output "vpc_id" {
  value = aws_vpc.main.id
}