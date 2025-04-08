terraform {
  backend "s3" {
    bucket         = "s3-bucket-avatar"
    key            = "terraform_statefile"
    region         = "us-east-1"
    dynamodb_table = "Avatar_DynamoDB"
  }
}