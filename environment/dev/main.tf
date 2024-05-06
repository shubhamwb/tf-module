variable "project_name" {
  default = "tfModule"
  type    = string
}

locals {
  environment = basename(abspath(dirname(path.module)))
  common_tags = {
    Owner   = "ShubhamBorkar"
    Project = var.project_name
    Env     = local.environment
  }
}

module "ec2" {
  source         = "../../modules/ec2"
  instance_count = 1
  instance_ami   = "ami-04b70fa74e45c3917" #ubuntu us-east-1 
  instance_type  = "t2.micro"
  subnet_id      = module.vpc.public_subnets
  instance_name  = "nginx"
  project        = var.project_name
  sg_name        = module.security_group.sg_id
  key_name       = "lenovo_ubuntu"
  user_data      = file("../../userdata/${local.environment}.sh")
  env            = local.environment
  tags           = local.common_tags
}

module "vpc" {
  source                    = "../../modules/vpc"
  vpc_cidr_block            = "10.0.0.0/16"
  instance_tenancy          = "default"
  public_subnet_cidr_block  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnet_cidr_block = ["10.0.4.0/24", "10.0.5.0/24"]
  availability_zones        = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  env                       = basename(abspath(dirname(path.module)))
  project                   = var.project_name
  tags                      = local.common_tags
}

module "security_group" {
  source  = "../../modules/security_group"
  sg_name = "sg"
  vpc_id  = module.vpc.vpc_id
  env     = local.environment
  project = var.project_name
  tags    = local.common_tags
}