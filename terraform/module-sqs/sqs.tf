resource "aws_sqs_queue" "main" {
  name                      = var.queue_name
  delay_seconds             = 0
  receive_wait_time_seconds = 20
  max_message_size          = 1024
  message_retention_seconds = 86400

  tags = var.tags
}

# Policy to Queue
resource "aws_sqs_queue_policy" "main" {
  queue_url = aws_sqs_queue.main.id
  policy    = data.template_file.policy_sqs.rendered
}

data "template_file" "policy_sqs" {
  template = var.policy
  vars = {
    SQSQueueArn = aws_sqs_queue.main.arn
  }
}