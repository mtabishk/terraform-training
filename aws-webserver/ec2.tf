# Creating an EC2 Instance
resource "aws_instance" "webserver" {
  ami           = "ami-010aff33ed5991201"
  instance_type = "t2.micro"
  tags = {
    "name" = "webosfromterraform"
  }
  # this security group is already created in aws cloud. It allows all ports and ip addresses (0.0.0.0/0).
  vpc_security_group_ids = ["sg-0344355829b3965a2"]
  key_name               = "aws-arth-key"
}
