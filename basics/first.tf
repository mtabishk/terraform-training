provider "aws" {
  region = "ap-south-1"

}
resource "aws_instance" "web" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  tags = {
    "name" = "webosfromterraform"
  }
  vpc_security_group_ids = ["sg-0344355829b3965a2"]
  key_name               = "aws-arth-key"
}
