# Connecting to EC2 Instance and executing the commands for configuration of webserver
resource "null_resource" "apache_webserver_provisioner" {
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

