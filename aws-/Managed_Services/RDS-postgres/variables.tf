
# credentials from tfvars file

# to update this with restricted IP range for security
variable "cidr_block" {
  default = ["0.0.0.0"]
}