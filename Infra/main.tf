provider "aws" {
  region = var.aws_region
}

resource "aws_sqs_queue" "terraform_queue" {
    name = "SQS-principal-${terraform.workspace}"
    tags = {
        Name = "SQS-principal-${terraform.workspace}"
    }
}