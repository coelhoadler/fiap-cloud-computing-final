provider "aws" {
  region = var.aws_region
}

resource "aws_sqs_queue" "terraform_queue" {
    name = "${format("my-sqs-%03d", count.index + 1)}"
    
    count = var.quantidade_filas
    
    tags = {
        Name = "${format("my-sqs-%03d", count.index + 1)}"
    }
}