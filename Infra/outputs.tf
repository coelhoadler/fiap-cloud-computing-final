data "aws_caller_identity" "current" {}

output "sqs_principal_arn" {
  value = "${aws_sqs_queue.terraform_queue.arn}"
}

output "sqs_principal_url" {
  value = "${aws_sqs_queue.terraform_queue.id}"
}

output "sqs_dlq_url" {
  value = "${aws_sqs_queue.terraform_queue_deadletter.id}"
}

output "sqs_principal_dlq_arn" {
  value = "${aws_sqs_queue.terraform_queue_deadletter.arn}"
}

output "sns_deadletters_notifyer_arn" {
  value = "${aws_sns_topic.deadletters_notifyer.arn}"
}

output "filename" {
  value = "${module.localfile.filename}"
}

output "content" {
  value = "${module.localfile.content}"
}

output "serverless-stage" {
  value = ${terraform.workspace}
}

output "serverless-userId" {
  value = data.aws_caller_identity.current.account_id
}