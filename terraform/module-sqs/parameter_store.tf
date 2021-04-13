resource "aws_ssm_parameter" "main" {
  name  = "/${var.queue_name}/queue_url"
  type  = "String"
  value = aws_sqs_queue.main.id
}