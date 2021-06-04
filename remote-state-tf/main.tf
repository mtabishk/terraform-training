provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

terraform {
  backend "s3" {
    bucket         = "my-tf-test-bucket-mtabishk"
    key            = "mystate.tfstate" # object == key
    region         = "ap-south-1"
    dynamodb_table = "tfState-lock-table"
  }

}
