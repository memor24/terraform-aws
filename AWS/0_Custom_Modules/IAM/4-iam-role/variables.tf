#####  IAM Role vars ########
variable "role_name" {
  description = "The name of the role"
  type        = string
}


#####  conditional vars ######

variable "create_role" {
  description = "Create IAM Role"
  type        = bool
  default     = false
}