resource "aws_ebs_volume" "ebsVolWebserver" {
  availability_zone = aws_instance.webserver.availability_zone
  size              = 10

  tags = {
    Name = "ebsVolWebserver"
  }
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.ebsVolWebserver.id
  instance_id = aws_instance.webserver.id
}

# Connecting to EC2 Instance, partitioning and foramting the EBS Volume
resource "null_resource" "ebs_vol_mount_provisioner" {
  triggers = {
    public_ip = aws_instance.webserver.public_ip
  }
  depends_on = [
    null_resource.apache_webserver_provisioner
  ]

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
