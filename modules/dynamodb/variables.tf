variable "table_name" {
  description = "Name of the DynamoDB table."
  type        = string
}

variable "hash_key" {
  description = "Hash key attribute name."
  type        = string
}

variable "hash_key_type" {
  description = "Hash key attribute type (S, N, B)."
  type        = string
  default     = "S"
}

variable "additional_attributes" {
  description = "List of additional attribute maps (name, type)."
  type        = list(object({ name = string, type = string }))
  default     = []
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "KMS key ARN for DynamoDB encryption."
  type        = string
} 