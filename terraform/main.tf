provider "aws" {}

terraform {
  backend "s3" {}
}

locals {
  appname = "app-feedback"
  
  tags = {
    Environment = "test"
  }
}

# User Worker
module "iam_worker" {
  source    = "./module-iam"
  username  = "${local.appname}-worker"
}

# User API
module "iam_api" {
  source    = "./module-iam"
  username  = "${local.appname}-api"
}

module "sqs" {
  source        = "./module-sqs"
  queue_name    = local.appname
  policy        = data.template_file.policy_sqs.rendered
  
  tags          = local.tags
}