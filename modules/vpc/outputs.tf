output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}

output "isolated_subnet_ids" {
  value = aws_subnet.isolated[*].id
}

output "frontend_pods_sg_id" {
  description = "Security group ID for frontend pods (SGP)"
  value       = aws_security_group.frontend_pods.id
}

output "backend_pods_sg_id" {
  description = "Security group ID for backend pods (SGP)"
  value       = aws_security_group.backend_pods.id
} 