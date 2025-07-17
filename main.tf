# tfsec:ignore:aws-ec2-no-public-ingress-sgr
# tfsec:ignore:aws-ec2-no-public-egress-sgr
resource "aws_security_group" "alb" {
  name        = "eks-infra-alb-sg"
  description = "ALB security group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP from anywhere (public ALB)"
  }
  # Add HTTPS/other rules as needed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }
}

module "vpc" {
  source                = "./modules/vpc"
  name                  = "eks-infra"
  vpc_cidr              = "10.0.0.0/16"
  public_subnet_cidrs   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs  = ["10.0.11.0/24", "10.0.12.0/24"]
  isolated_subnet_cidrs = ["10.0.21.0/24", "10.0.22.0/24"]
  azs                   = slice(data.aws_availability_zones.available.names, 0, 2)
  kms_key_arn           = aws_kms_key.main.arn
  alb_sg_id             = aws_security_group.alb.id
  aws_region            = var.aws_region
  tags = {
    Project     = "eks-infra"
    Environment = "dev"
  }
}

module "iam" {
  source             = "./modules/iam"
  name               = "eks-infra"
  kms_key_arn        = aws_kms_key.main.arn
  dynamodb_table_arn = module.dynamodb.table_arn
  tags = {
    Project     = "eks-infra"
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
    Project     = "eks-infra"
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
    Project     = "eks-infra"
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
    Project     = "eks-infra"
    Environment = "dev"
  }
}