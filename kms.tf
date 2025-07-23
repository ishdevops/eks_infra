resource "aws_kms_key" "main" {
  description             = "KMS key for EKS Infra resources"
  enable_key_rotation     = true
  deletion_window_in_days = 10

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowAdminViaOIDC"
        Effect = "Allow"
        Principal = {
          AWS = data.aws_iam_role.github_oidc.arn
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowEKSClusterAndNode"
        Effect = "Allow"
        Principal = {
          AWS = [
            module.iam.eks_cluster_role_arn,
            module.iam.eks_node_role_arn
          ]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      }
    ]
  })
} 