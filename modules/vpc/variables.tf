variable "name" {
  description = "Name prefix for EKS Infra VPC resources."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDRs."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of private subnet CIDRs."
  type        = list(string)
}

variable "isolated_subnet_cidrs" {
  description = "List of isolated subnet CIDRs."
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones."
  type        = list(string)
}

variable "tags" {
  description = "Tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "kms_key_arn" {
  description = "KMS key ARN for encrypting VPC flow logs"
  type        = string
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB to allow ingress to frontend pods."
  type        = string
}

variable "aws_region" {
  description = "AWS region for VPC endpoint services."
  type        = string
} 