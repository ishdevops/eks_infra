resource "aws_ecr_repository" "microservice_app" {
  name = "microservice-app"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    Project = "eks-infra"
    Environment = "dev"
  }
} 