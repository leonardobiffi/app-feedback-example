# Create .env used in docker-compose
resource "null_resource" "env_worker" {
  triggers = {
    always_run = timestamp()
  }
  
  provisioner "local-exec" {
    command = "sh scripts/create_env.sh worker $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $QUEUE_SSM_PARAMETER"

    environment = {
      AWS_ACCESS_KEY_ID     = module.iam_worker.iam_access_key_id
      AWS_SECRET_ACCESS_KEY = module.iam_worker.iam_secret_access_key
      QUEUE_SSM_PARAMETER   = module.sqs.ssm_parameter_path
    }
  }
}

# Create .env used in docker-compose
resource "null_resource" "env_api" {
  triggers = {
    always_run = timestamp()
  }
  
  provisioner "local-exec" {
    command = "sh scripts/create_env.sh api $AWS_ACCESS_KEY_ID $AWS_SECRET_ACCESS_KEY $QUEUE_SSM_PARAMETER"

    environment = {
      AWS_ACCESS_KEY_ID     = module.iam_api.iam_access_key_id
      AWS_SECRET_ACCESS_KEY = module.iam_api.iam_secret_access_key
      QUEUE_SSM_PARAMETER   = module.sqs.ssm_parameter_path
    }
  }
}