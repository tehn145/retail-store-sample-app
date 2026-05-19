variable "environment" {
  description = "Environment name"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN from EKS cluster"
  type        = string
  default     = null # Set to null by default, will be provided by EKS module output
}
