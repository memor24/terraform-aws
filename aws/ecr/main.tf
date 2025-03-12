############
terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.7"
    }
  }
}

provider aws {
    region = "us-west-2"
  }
############
resource "aws_ecr_repository" "new_ecr_repo" {
  name = "my-ecr"

  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    Env     = "demo"
    Project = "terraform-aws"
  }
}
##########
output "ecr_repo_url" {
  value = aws_ecr_repository.new_ecr_repo.repository_url
}