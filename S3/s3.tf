resource "aws_s3_bucket" "bucket_s3" {
  bucket = "s3-remotely-state-75aoj"
  acl = "private"

  tags = {
    Name = "s3-remotely-state-75aoj"
    Environment = "admin"
  }
}