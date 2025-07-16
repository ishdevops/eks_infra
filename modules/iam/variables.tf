variable "name" {
  description = "Name prefix for IAM resources."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
} 