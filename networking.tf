resource "aws_vpc" "vpc-obl" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC_OBL_Terraform"
    Terraform = "True"
  }
}

resource "aws_subnet" "private-subnet-obl" {
  vpc_id                  = aws_vpc.vpc-obl.id
  availability_zone       = "us-east-1a"
  cidr_block              = "172.16.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Subnet_OBL_Terraform"
    Terraform = "True"
  }
}

resource "aws_subnet" "private-subnet-obl1" {
  vpc_id                  = aws_vpc.vpc-obl.id
  availability_zone       = "us-east-1b"
  cidr_block              = "172.16.2.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "Subnet_OBL1_Terraform"
    Terraform = "True"
  }
}

resource "aws_internet_gateway" "igw-obl" {
  vpc_id = aws_vpc.vpc-obl.id

  tags = {
    Name = "igw_OBL_Terraform"
    Terraform = "True"
  }
}

resource "aws_default_route_table" "obl-rt" {
  default_route_table_id = aws_vpc.vpc-obl.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-obl.id
  }

  tags = {
    Name = "OBL_default_table"
    Terraform = "True"
  }
}

resource "aws_security_group" "sg-efs-obl" {
  name        = "obl-efs-sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc-obl.id

  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.private-subnet-obl.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OBL-sg"
    Terraform = "True"
  }
}

resource "aws_security_group" "sg-ssh-obl" {
  name        = "obl-ssh-sg"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = aws_vpc.vpc-obl.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OBL-ssh-sg"
    Terraform = "True"
  }
}

resource "aws_security_group" "sg-db-obl" {
  name        = "obl-db-sg"
  description = "Allow MySQL traffic"
  vpc_id      = aws_vpc.vpc-obl.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "OBL-sg"
    Terraform = "True"
  }
}

resource "aws_security_group" "sg-http-obl" {
  name = "obl-web-sg"
  vpc_id = aws_vpc.vpc-obl.id

ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
