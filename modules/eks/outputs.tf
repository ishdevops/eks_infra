output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.this.certificate_authority[0].data
}

output "node_group_role_arn" {
  value = var.node_role_arn
}

output "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider."
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_provider_url" {
  description = "URL of the EKS OIDC provider (without https://)."
  value       = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")
} 