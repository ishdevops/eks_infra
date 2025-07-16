module "vpc" {
  source = "./modules/vpc"
  name                  = "eks-infra"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  isolated_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
  azs                   = slice(data.aws_availability_zones.available.names, 0, 2)
  kms_key_arn           = aws_kms_key.main.arn
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
}

module "iam" {
  source = "./modules/iam"
  name   = "eks-infra"
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
}

module "eks" {
  source              = "./modules/eks"
  cluster_name        = "eks-infra-eks"
  kubernetes_version  = "1.29"
  private_subnet_ids  = module.vpc.private_subnet_ids
  cluster_role_arn    = module.iam.eks_cluster_role_arn
  node_role_arn       = module.iam.eks_node_role_arn
  node_instance_type  = "t3.medium"
  node_desired_size   = 2
  node_min_size       = 2
  node_max_size       = 4
  secrets_kms_key_arn = aws_kms_key.main.arn
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
}

module "dynamodb" {
  source                = "./modules/dynamodb"
  table_name            = "eks-infra-table"
  hash_key              = "id"
  hash_key_type         = "S"
  additional_attributes = []
  kms_key_arn           = aws_kms_key.main.arn
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
}

module "secrets_manager" {
  source        = "./modules/secrets_manager"
  name          = "eks-infra-secret"
  description   = "App secret for eks infra"
  secret_string = "{\"db_password\":\"supersecret\"}"
  kms_key_arn   = aws_kms_key.main.arn
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
}

resource "aws_kms_key" "main" {
  description             = "KMS key for EKS Infra resources"
  enable_key_rotation     = true
  deletion_window_in_days = 10
}

# Pass the KMS key ARN to modules/resources as needed 