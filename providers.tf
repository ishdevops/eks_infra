terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0"
    }
  }
  backend "s3" {
    bucket         = "ishaqsubedar-eks-infra-tf-remote-state"
    key            = "eks_infra/terraform.tfstate"
    region         = "eu-west-2"
    dynamodb_table = "ishaqsubedar-eks-infra-tf-remote-state-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}

provider "helm" {
  alias = "eks"
  kubernetes = {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
} 