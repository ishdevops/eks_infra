data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

data "aws_availability_zones" "available" {}

data "aws_iam_role" "github_oidc" {
  name = "github-actions-oidc-role"
} 