output "oidc_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "s3_bucket" {
  value = aws_s3_bucket.tf_state.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.tf_lock.name
} 