variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_cidr_block" {
  type = string
}

variable "instance_tenancy" {
  type = string
}

variable "public_subnet_cidr_block" {
  type = list(any)
}

variable "availability_zones" {
  type = list(string)
}

variable "private_subnet_cidr_block" {
  type = list(string)
}
