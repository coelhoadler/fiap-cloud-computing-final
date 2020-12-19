terraform {
  backend "s3" {
    bucket = "michel-s3-remotely-state-75aoj"
    key    = "terraform-log"
    region = "us-east-1"
  }
}