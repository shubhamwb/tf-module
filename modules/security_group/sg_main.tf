resource "aws_security_group" "main" {
  name   = format("%s-%s-%s", var.project, var.env, "sg")
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    description = "all http protocol"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    description = "allow ssh protocol"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, { "Name" = format("%s-%s-%s", var.project, var.env, "sg") })
}