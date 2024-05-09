output "public_subnets" {
  value = module.vpc.public_subnets
}

output "sg_id" {
  value = module.security_group.sg_id
}

output "name" {
  value = module.ec2.public_ip
}

output "public_ip" {
  value = module.ec2.public_ip
}