# EKS Infrastructure

[![Terraform CI/CD](https://github.com/ishaqsubedar/eks_infra/actions/workflows/terraform.yml/badge.svg)](https://github.com/ishaqsubedar/eks_infra/actions/workflows/terraform.yml)

This repository contains the infrastructure-as-code for the EKS Infrastructure project, including EKS, VPC, IAM, DynamoDB, Secrets Manager, Istio, Kyverno, and more, managed with Terraform.

## Getting Started

1. **Bootstrap the environment** (OIDC role, S3 backend, DynamoDB table):
   ```sh
   cd bootstrap
   terraform init
   terraform apply
   ```
2. **Update the main backend config** with the S3 bucket and DynamoDB table outputs.
3. **Run Terraform workflows** via GitHub Actions (see `.github/workflows/terraform.yml`).

## Terraform Modules
- VPC
- EKS
- IAM
- DynamoDB
- Secrets Manager
- Istio (Helm)
- Kyverno (Helm)
- External Secrets Operator (Helm)
- ECR

## Terraform Docs
<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->

## Updating Terraform Docs
To update the Terraform documentation in this README, run:

```sh
terraform-docs markdown table . > README.md
```

Or use the provided GitHub Actions workflow (see below). 
