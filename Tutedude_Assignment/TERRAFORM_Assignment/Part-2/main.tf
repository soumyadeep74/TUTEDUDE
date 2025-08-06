terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

# ---------------------------
# VPC and Networking Resources
# ---------------------------

resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "main-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "main-rt"
  }
}

resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.rt.id
}

# ---------------------------
# Security Groups
# ---------------------------

# Flask SG (no mutual reference)
resource "aws_security_group" "flask_sg" {
  name        = "flask-sg"
  description = "Flask backend SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow access to Flask (port 5000)"
    from_port   = 5000
    to_port     = 5000
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
    Name = "flask-sg"
  }
}

# Express SG (no mutual reference)
resource "aws_security_group" "express_sg" {
  name        = "express-sg"
  description = "Express frontend SG"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow access to Express (port 3000)"
    from_port   = 3000
    to_port     = 3000
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
    Name = "express-sg"
  }
}

# Mutual access between Flask and Express SGs (avoid cycle)
resource "aws_security_group_rule" "express_to_flask" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.express_sg.id
  security_group_id        = aws_security_group.flask_sg.id
  description              = "Allow Express to access Flask"
}

resource "aws_security_group_rule" "flask_to_express" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.flask_sg.id
  security_group_id        = aws_security_group.express_sg.id
  description              = "Allow Flask to access Express"
}

# ---------------------------
# EC2 Instances
# ---------------------------

resource "aws_instance" "flask" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.flask_sg.id]

  user_data = file("${path.module}/ec2/flask.sh")

  tags = {
    Name = "Flask-Backend"
  }
}

resource "aws_instance" "express" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.main.id
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.express_sg.id]

  user_data = file("${path.module}/ec2/express.sh")

  tags = {
    Name = "Express-Frontend"
  }
}
