variable "github_repo" {
  description = "GitHub repo in the format owner/repo (e.g., ishaqsubedar/data_pipeline)"
  type        = string
}

variable "region" {
  description = "AWS region for backend resources."
  type        = string
  default     = "us-west-2"
}

variable "bucket_name" {
  description = "Name for the S3 backend bucket."
  type        = string
} 