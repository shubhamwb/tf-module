output "public_ip" {
  value = {
    for instance in aws_instance.main : instance.id => {
      name      = instance.tags["Name"]
      public_ip = instance.public_ip
    }
  }
}