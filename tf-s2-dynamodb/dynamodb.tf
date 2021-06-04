resource "aws_dynamodb_table" "tf-dynamodb-table" {
  name           = "tfState-lock-table"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "tf-dynamodb-table"
    Environment = "test"
  }
}
