resource "aws_instance" "main" {
  count         = var.instance_count
  ami           = var.instance_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id 
  tags          = merge(var.tags, { "Name" = format("%s-%s-%s-%s", var.project, var.env, var.instance_name, count.index + 1) })
}

