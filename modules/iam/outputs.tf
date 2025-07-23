output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster.arn
}

output "eks_node_role_arn" {
  value = aws_iam_role.eks_node.arn
}

output "backend_irsa_role_arn" {
  description = "IAM role ARN for backend IRSA ServiceAccount"
  value       = aws_iam_role.backend_irsa.arn
}