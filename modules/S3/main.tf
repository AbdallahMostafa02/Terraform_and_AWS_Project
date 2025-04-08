resource "aws_s3_bucket" "s3_avatar" {
  bucket = "s3-bucket-avatar"
  tags = {
    Name = "s3-avatar"
  }
}
