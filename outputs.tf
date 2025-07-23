output "ecr_repo_url" {
  value = aws_ecr_repository.microservice_app.repository_url
}
output "kms_key_arn" {
  value = aws_kms_key.main.arn
}

output "frontend_pods_sg_id" {
  description = "Security group ID for frontend pods (SGP)"
  value       = module.vpc.frontend_pods_sg_id
}

output "backend_pods_sg_id" {
  description = "Security group ID for backend pods (SGP)"
  value       = module.vpc.backend_pods_sg_id
}

output "alb_sg_id" {
  description = "Security group ID for the ALB (for use in app repo)"
  value       = aws_security_group.alb.id
}