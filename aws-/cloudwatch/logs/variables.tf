variable "log_group_name" {
  type        = string
  default     = ""
  description = "my-app-logs"
}

variable "retention_in_days" {
  type        = number
  default     = 7
  description = "The number of days to retain log events."
}

variable "log_stream_name" {
  type        = string
  default     = ""
  description = "my-app-instance-1"
}

variable "environment" {
  type        = string
  default     = ""
  description = "dev"
}
