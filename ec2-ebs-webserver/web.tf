provider "aws" {
  profile = "default"
  region  = "ap-south-1"
}

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

# Connecting to EC2 Instance and executing the commands for configuration of webserver
resource "null_resource" "null_provisioner" {
  triggers = {
    public_ip = aws_instance.webserver.public_ip
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/mtabishk/Downloads/aws-arth-key.pem")
    host        = aws_instance.webserver.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php -y",
      "sudo systemctl enable httpd --now",
    ]
  }
}

# Creating and attaching the EBS Volume with the EC2 Instance
resource "aws_ebs_volume" "ebsVolWebserver" {
  availability_zone = aws_instance.webserver.availability_zone
  size              = 10

  tags = {
    Name = "ebsVolWebserver"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name  = "/dev/sdh"
  volume_id    = aws_ebs_volume.ebsVolWebserver.id
  instance_id  = aws_instance.webserver.id
  force_detach = true
}

# Connecting to EC2 Instance, partitioning and foramting the EBS Volume
resource "null_resource" "ebs_vol_mount_provisioner" {
  triggers = {
    public_ip = aws_instance.webserver.public_ip
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/mtabishk/Downloads/aws-arth-key.pem")
    host        = aws_instance.webserver.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mkfs.ext4 /dev/sdh",
      "sudo mount /dev/sdh /var/www/html",
      "sudo yum install git -y",
      "sudo git clone https://github.com/vimallinuxworld13/gitphptest.git /var/www/html"
    ]
  }
}

resource "null_resource" "local_provisioner" {
  triggers = {
    public_ip = aws_instance.webserver.public_ip
  }

  provisioner "local-exec" {
    command = "google-chrome http://${aws_instance.webserver.public_ip}/"
  }
}
