output "sqs_principal_arn" {
  value = "${aws_sqs_queue.terraform_queue.arn}"
}

output "sqs_principal_url" {
  value = "${aws_sqs_queue.terraform_queue.id}"
}

output "sqs_principal_dlq_arn" {
  value = "${aws_sqs_queue.terraform_queue_deadletter.arn}"
}

output "sns_deadletters_notifyer_arn" {
  value = "${aws_sns_topic.deadletters_notifyer.arn}"
}