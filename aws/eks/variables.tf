variable region {
  type        = string
  default     = "us-west-2"
}

variable cluster_name {
  type        = string
  default = "my-new-cluster"
  description = "The name of the EKS cluster"
}

