provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

variable "aws_instance_types" {
  type = map(any)
  default = {
    dev-ws  = "t2.micro"
    test-ws = "t2.small"
    prod-ws = "t2.large"
  }
}
# Creating an EC2 Instance
resource "aws_instance" "webserver" {
  ami           = "ami-010aff33ed5991201"
  instance_type = lookup(var.aws_instance_types, terraform.workspace)
  tags = {
    "name" = "webosfromterraform"
  }
  vpc_security_group_ids = ["sg-0344355829b3965a2"]
  key_name               = "aws-arth-key"
}

output "current_workspace" {
  value = terraform.workspace
}
