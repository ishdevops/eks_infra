output "ecr_repo_url" {
  value = aws_ecr_repository.microservice_app.repository_url
}
output "kms_key_arn" {
  value = aws_kms_key.main.arn
} 