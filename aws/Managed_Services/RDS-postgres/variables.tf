# to update this with restricted IP range for security
variable "cidr_block" {
  default = ["0.0.0.0"]
}

# credentials from tfvars file to access the RDS instance
variable "username" {
  description = "The username for the database"
}
variable "password" {
  description = "The password for the database"
}

