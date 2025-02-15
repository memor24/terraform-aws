variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "aws region for the service resource"
}

variable "devops_users" {
  description = "List of IAM devops users to create"
  type        = list(string)
  default     = ["devops1", "devops2", "devops3"]
}