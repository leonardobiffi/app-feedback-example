data "template_file" "policy_sqs" {
  template = file("${path.module}/policies/policy-sqs.json")
  vars = {
    SQSQueueArn       = module.sqs.queue_arn
    WorkerIAMUserArn  = module.iam_worker.iam_user_arn
    ApiIAMUserArn     = module.iam_api.iam_user_arn
  }
}