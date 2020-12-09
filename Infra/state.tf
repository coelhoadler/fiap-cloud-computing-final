terraform {
  backend "s3" {
    bucket = "s3-remotely-state-75aoj"
    key    = "teste"
    region = "us-east-1"
  }
}