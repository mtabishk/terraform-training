provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "web" {
  ami           = "ami-010aff33ed5991201"
  instance_type = var.myInstanceType

  tags = {
    Name = "HelloWorld"
  }
}
