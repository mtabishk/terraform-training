resource "aws_s3_bucket" "mybucket" {
  bucket = "my-tf-test-bucket-mtabishk"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "My Terraform bucket"
  }
}
