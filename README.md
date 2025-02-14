# Amazon AWS with Terraform
In this repository, the AWS main services can be created using Terraform and its state management for a clean automation of AWS provision.

Use AWS CLI to export credentials:
```
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
```

For development or testing, use an AWS sandbox or LocalStack [link].


Then use Terraform to create and manage the services:
```
terraform fmt

terraform init
terraform validate

terraform plan
terraform apply

terraform destroy
```
