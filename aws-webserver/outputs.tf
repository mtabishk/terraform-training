output "myPublicIP" {
  value = aws_instance.webserver.public_ip
}
