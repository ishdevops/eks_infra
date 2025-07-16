resource "aws_ecr_repository" "microservice_app" {
  name = "microservice-app"
  image_tag_mutability = "IMMUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  # Optional: Uncomment and set your KMS key if you want customer-managed encryption
  # encryption_configuration {
  #   encryption_type = "KMS"
  #   kms_key = aws_kms_key.ecr.arn
  # }
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
} 