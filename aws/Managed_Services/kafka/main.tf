## vpc resources for kafka
module vpc {
  source = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"
  name = "kafka-vpc"
  cidr = "10.0.0.16"

    azs = ["us-east-1a", "us-east-1b", "us-east-1c"]
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
 
    enable_nat_gateway = true
}

module security_group {
  source = "terraform-aws-modules/security-group/aws"
  version = "4.0.0"
  name = "kafka-sg"
  description = "Security group for kafka"
  vpc_id = module.vpc.vpc_id

  ingress_cidr_blocks = [
    {   cidr10.0.0.0/16       # allows traffic within the vpc 
        from_port = 9092
        to_port = 9092
        protocol = "tcp"
        description = "kafka" # for streaming and processing data
    },
    {   cidr10.0.0.0/16        
        from_port = 2181
        to_port = 2181
        protocol = "tcp"
        description = "zookeeper" # for control and metadata management
    },
    {   cidr10.0.0.0/16        
        from_port = 22
        to_port = 22
        protocol = "tcp"
        description = "ssh"
    }
    ]
  egress_cidr_blocks = [
    {   cidr0.0.0.0/0       # to be limited for security
        from_port = 0       # to be limited for security
        to_port = 0
        protocol = "-1"
        description = "all"
    }
  ] 

    tags = {
        Name = "kafka-sg"
    }
}

## kafka resources, or alternatively use mks (managed kafka service) modules
module kafka {
  source = "terraform-aws-modules/mks/aws"
  version = "3.5.0"
  cluster_name = "kafka-cluster"
  vpc_id = module.vpc.vpc_id
  security_group_ids = [module.security_group.security_group_id]
  subnet_ids = module.vpc.private_subnets

  broker_node_group = {
    instance_type = "kafka.m5.large"
    broker_az_distribution = "DEFAULT"
    ebs_volume_size = 100
    ebs_volume_type = "gp2"
    ebs_iops = 100
    ebs_encrypted = false
    volume_kms_key_id = ""
    volume_throughput = 100
    volume_size = 100
    volume_type = "gp2"
    volume_iops = 100
    volume_encrypted = false
  }
  client_node_group = {
    instance_type = "kafka.m5.large"
    client_az_distribution = "DEFAULT"
    ebs_volume_size = 100
    ebs_volume_type = "gp2"
    ebs_iops = 100
    ebs_encrypted = false
    volume_kms_key_id = ""
    volume_throughput = 100
    volume_size = 100
    volume_type = "gp2"
    volume_iops = 100
    volume_encrypted = false
  }
  monitoring = {
    enhanced_monitoring = "DEFAULT"
    cloudwatch_logs = {
      log_group = "kafka-logs"
      retention = 7 #days
    }
  }
  encryption = {
    encryption_at_rest = "DEFAULT"
    encryption_in_transit = {
      client_broker = "TLS_PLAINTEXT"
      in_cluster    = true
    }
  }

  tags = {
    Environment = "dev"
  }
}