terraform {
  backend "s3" {
    bucket = "s3-remotely-state-75aoj-202012"
    key    = "terraform-log"
    region = "us-east-1"
  }
}