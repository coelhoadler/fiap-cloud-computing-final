provider "aws" {
  region = var.aws_region
}

module "localfile" {
  source = "./modules/file"
  filename = var.filename
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

/*
    Abaixo as subscrições no SNS, feitas para sms, pois conforme o link abaixo o protocolo email SMTP não é suportado no terraform, conforme diz a documentação abaixo:
    
    https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription#email
    
    Unsupported protocols include the following:

    email -- delivery of message via SMTP
    email-json -- delivery of JSON-encoded message via SMTP
    
    These are unsupported because the endpoint needs to be authorized and does not generate an ARN until the target email address has been validated. This breaks the Terraform model and as a result are not currently supported.

*/

resource "aws_sns_topic_subscription" "sms-subscription-kelvin" {
    topic_arn = aws_sns_topic.deadletters_notifyer.arn
    protocol = "sms"
    endpoint = "5511984333790"
	filter_policy = jsonencode(map("target",list("all")))
}

resource "aws_sns_topic_subscription" "sms-subscription-michel" {
    topic_arn = aws_sns_topic.deadletters_notifyer.arn
    protocol = "sms"
    endpoint = "5511962324706"
	filter_policy = jsonencode(map("target",list("all")))
}

resource "aws_sns_topic_subscription" "sms-subscription-beatriz" {
    topic_arn = aws_sns_topic.deadletters_notifyer.arn
    protocol = "sms"
    endpoint = "5511968980728"
	filter_policy = jsonencode(map("target",list("all")))
}

resource "aws_sns_topic_subscription" "sms-subscription-adler" {
    topic_arn = aws_sns_topic.deadletters_notifyer.arn
    protocol = "sms"
    endpoint = "5513996275325"
	filter_policy = jsonencode(map("target",list("all")))
}