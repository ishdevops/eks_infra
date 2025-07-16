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