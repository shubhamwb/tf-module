locals {
  environment         = basename(abspath(dirname(path.module)))
  cidr_block_anywhere = "0.0.0.0/0"
  common_tags = {
    Owner   = "ShubhamBorkar"
    Project = "tfModule"
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
  project        = local.common_tags.Project
  sg_name        = module.security_group.sg_id
  key_name       = "lenovo_ubuntu"
  user_data      = file("../../userdata/${local.environment}.sh")
  env            = local.environment
  tags           = local.common_tags
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr_block       = "15.4.0.0/16"
  instance_tenancy     = "default"
  public_subnet_count  = 1
  private_subnet_count = 1
  cidr_block_anywhere  = local.cidr_block_anywhere
  availability_zones   = ["us-east-1a", "us-east-1b", "us-east-1c"]
  env                  = basename(abspath(dirname(path.module)))
  project              = local.common_tags.Project
  tags                 = local.common_tags
}

module "security_group" {
  source              = "../../modules/security_group"
  vpc_id              = module.vpc.vpc_id
  cidr_block_anywhere = local.cidr_block_anywhere
  env                 = local.environment
  project             = local.common_tags.Project
  tags                = local.common_tags
}