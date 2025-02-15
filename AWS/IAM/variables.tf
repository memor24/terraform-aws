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

variable "user_name" {
  type        = string
  default     = "devops2"
  description = "The name of an IAM user"
}

variable "aws_iam_policy_name" {
  type        = string
  default     = "AmazonS3ReadOnlyAccess"
  description = "The name of an IAM policy"
}