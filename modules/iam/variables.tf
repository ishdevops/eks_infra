variable "name" {
  description = "Name prefix for IAM resources."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "KMS key ARN for EKS access permissions."
  type        = string
}

variable "dynamodb_table_arn" {
  description = "DynamoDB table ARN for EKS access permissions."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider."
  type        = string
}

variable "oidc_provider_url" {
  description = "URL of the EKS OIDC provider (without https://)."
  type        = string
}

variable "backend_namespace" {
  description = "Kubernetes namespace for the backend ServiceAccount."
  type        = string
}

variable "backend_serviceaccount" {
  description = "Name of the backend ServiceAccount."
  type        = string
}

variable "dummy_api_key_arn" {
  description = "ARN of the dummy API key secret in AWS Secrets Manager."
  type        = string
} 