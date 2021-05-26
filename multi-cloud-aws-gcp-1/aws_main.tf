resource "aws_instance" "myawsInstance" {
  ami           = var.awsAmi
  instance_type = var.awsInstance
}

