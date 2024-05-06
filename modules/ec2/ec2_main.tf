resource "aws_instance" "main" {
  count           = var.instance_count
  ami             = var.instance_ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  security_groups = [var.sg_name]
  key_name        = var.key_name
  user_data       = var.user_data
  tags            = merge(var.tags, { "Name" = format("%s-%s-%s-%s", var.project, var.env, var.instance_name, count.index + 1) })
}