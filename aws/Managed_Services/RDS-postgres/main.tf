
module "rds_postgres_db_instance" {
  source  = "terraform-aws-modules/rds/aws//modules/db_instance"
  version = "6.10.0"

# required variables
  identifier = "mydb"
  db_name = "my-postgres-db"
  engine     = "postgres"
  engine_version = "16"
  instance_class = "db.t3.micro"   # db instance vcpu/memory/IO resource allocation
  allocated_storage = 10           # storage in Gb
  name = "mypgdb"                 
  username = var.username
  password = var.password
  port = 5432
  vpc_security_group_ids = [aws_security_group.default.id]
  db_subnet_group_name = aws_db_subnet_group.default.name
  publicly_accessible = false
}

## define db instance vpc, subnets, security group
# vpc
resource "aws_vpc" "default" {
  cidr_block = 10.0.0.0/16

  tags={
    Name="my-vpc"
  }
}

# subnets
resource "aws_subnet" "default" {
    vpc_id = aws_vpc.default.id
    count=2
    cidr_block = cidrsubnet(aws_vpc.default.cidr_block, 8, count.index) # spits the vpc cidr block into 2 subnets
    availability_zone = "us-east-1a" if count.index == 0 else "us-east-1b"
}

# db security group
resource "aws_security_group" "default" {
  name        = "my-rds-security-group"
  vpc_id      = aws_vpc.default.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks =  10.0.0.0/16
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block 
  }
}

