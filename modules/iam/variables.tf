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