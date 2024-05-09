variable "vpc_id" {
  type = string
}

variable "cidr_block_anywhere" {
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