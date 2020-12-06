provider "aws" {
  region = var.aws_region
}

resource "aws_sqs_queue" "terraform_queue_deadletter" {
    name = "SQS-principal-${terraform.workspace}-dlq"
    tags = {
        Name = "SQS-principal-${terraform.workspace}-dlq"
    }
}

resource "aws_sqs_queue" "terraform_queue" {
    name = "SQS-principal-${terraform.workspace}"
    tags = {
        Name = "SQS-principal-${terraform.workspace}"
    }
    redrive_policy = jsonencode({
        deadLetterTargetArn: aws_sqs_queue.terraform_queue_deadletter.arn,
        maxReceiveCount = 4
    })
}

resource "aws_sns_topic" "deadletters_notifyer" {
    name = "SNS-deadletters-notifyer-${terraform.workspace}"
    tags = {
        Name = "SNS-deadletters-notifyer-${terraform.workspace}"
    }
}

resource "aws_s3_bucket" "bucket_s3" {
  bucket = "S3-remote-state-${terraform.workspace}"
  acl    = "private"

  tags = {
    Name        = "S3-remote-state-${terraform.workspace}"
    Environment = "admin"
  }
}