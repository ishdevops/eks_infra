variable "name" {
  description = "Name of the secret."
  type        = string
}

variable "description" {
  description = "Description of the secret."
  type        = string
  default     = ""
}

variable "secret_string" {
  description = "Secret value as a string (JSON or plaintext)."
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
} 