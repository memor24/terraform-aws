variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "aws region for the service resource"
}


variable "aws_iam_policy_name" {
  type        = string
  default     = "AlexaForBusinessFullAccess"
  description = "The name of an IAM policy"
}