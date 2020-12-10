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
        maxReceiveCount = 1
    })
}

resource "aws_sns_topic" "deadletters_notifyer" {
    name = "SNS-deadletters-notifyer-${terraform.workspace}"
    tags = {
        Name = "SNS-deadletters-notifyer-${terraform.workspace}"
    }
}