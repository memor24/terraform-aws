## Infrastructure as Code
In this repo, I will be adding infrastructure as code templates using Terraform for each of the AWS main services like IAM, VPC, Lambda, etc.
```terraform
terraform init
```
To clean the code syntax, basic validation and detailed planning, use:
```
terraform fmt
terraform validate
terraform plan
```
To create the infrastructure as planned, use:
```
terraform apply
```
To delete (e.g. for cost control) and completely remove the infrastructure, use:
```
terraform destroy
```
#### Note
If you don't want to deploy them directly to AWS, you may also use Local Stack that helps with deploying to a localized AWS environment. 
First install a docker container of localstack, then launch it in a seperate terminal before terraform apply.
```
localstack start
```