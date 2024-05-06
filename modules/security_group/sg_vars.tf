variable "sg_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
variable "project" {
  type = string
}

variable "env" {
  type = string
}