# IAM User
resource "aws_iam_user" "main" {
  name = var.username
}

# Secret and Access Key
resource "aws_iam_access_key" "main" {
  user    = aws_iam_user.main.name
}

resource "aws_iam_user_policy" "main" {
  name = "policy-ssm"
  user = aws_iam_user.main.name

  policy = data.template_file.policy_ssm.rendered
}

data "template_file" "policy_ssm" {
  template = file("${path.module}/policies/policy-ssm.json")
}