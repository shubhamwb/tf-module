variable "instance_count" {
  type = number
}

variable "instance_ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "key_name" {
  type = string
}

variable "user_data" {
  type = string
}
variable "project" {
  type = string
}

variable "env" {
  type = string
}

variable "instance_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}