variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "aws region for the service resource"
}

variable "iam_account_alias" {
  type        = string
  default     = "department-4 account"
  description = "The alias for the AWS account"
}