output "queue_arn" {
  value = aws_sqs_queue.main.arn
}

output "ssm_parameter_path" {
  value = aws_ssm_parameter.main.name
}