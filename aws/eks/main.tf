provider "aws" {
  region = var.region
}

## eks cluster
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.34.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.28"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    enabled          = true
    desired_capacity = 2
    min_size         = 1
    max_size         = 3
    instance_types   = ["t3.medium"]
  }
}

# vpc supporting the eks cluster
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.0.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# local execs

resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command = "kubectl get nodes"
  }

  depends_on = [module.eks]
}

resource "null_resource" "update_kubeconfig" {
  triggers = {   # updates the kubeconfig file for a new cluster (name)
    cluster_name = module.eks.cluster_name
  }
  provisioner "local-exec" {
    command = "aws eks --region ${var.region} update-kubeconfig --name ${module.eks.cluster_name}"
  }

  depends_on = [module.eks]
}

