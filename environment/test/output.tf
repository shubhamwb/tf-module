output "public_subnets" {
  value = module.vpc.public_subnets
}

output "sg_id" {
  value = module.security_group.sg_id
}