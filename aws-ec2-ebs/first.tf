provider "aws" {
  profile = "default"
  region  = "ap-south-1"
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

output "myInstanceDetails" {
  value = aws_instance.web
}

output "myInstancePublicIP" {
  value = aws_instance.web.public_ip
}

output "myInstanceAvailabilityZone" {
  value = aws_instance.web.availability_zone
}

resource "aws_ebs_volume" "myEbsVolume" {
  availability_zone = aws_instance.web.availability_zone
  size              = 10

  tags = {
    Name = "myExternalVol"
  }
}


output "myEbs" {
  value = aws_ebs_volume.myEbsVolume
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.myEbsVolume.id
  instance_id = aws_instance.web.id
}
