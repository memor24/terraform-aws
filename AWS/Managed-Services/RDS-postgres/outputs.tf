output db_instance_arn {
  value       = module.db.db_instance_arn
  description = "The ARN of the RDS instance"
}

output db_instance_endpoint {
  value       = module.db.db_instance_endpoint
  description = "The connection endpoint"
}

## vpc outputs 
output vpc_id {
  value       = aws_vpc.default.id
  description = "The ID of the VPC"
}

output "subnet_ids" {
  value       = aws_subnet.default[*].id
  description = "The IDs of the subnets"
}

output "security_group_id" {
  value       = aws_security_group.default.id
  description = "The ID of the security group"
}
