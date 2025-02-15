#####  IAM Role vars ########
variable "iam_role_name" {
  description = "The name of the role"
  type        = string
  default="ec2_role"
}


#####  conditional vars ######

variable "create_role" {
  description = "Create IAM Role"
  type        = bool
  default     = false
}