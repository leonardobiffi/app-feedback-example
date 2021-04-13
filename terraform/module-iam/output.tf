output "iam_user_arn" {
  value = aws_iam_user.main.arn
}

output "iam_access_key_id" {
  value = aws_iam_access_key.main.id
}

output "iam_secret_access_key" {
  value = aws_iam_access_key.main.secret
}