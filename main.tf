terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
provider "aws" {
  region = "us-east-1"
}

# VPC
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_cidr
    instance_tenancy = "default"

    tags = {
      "Name" = "my_vpc"
    }
}

# 2 Subnets
resource "aws_subnet" "subnets" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr[count.index]
  availability_zone = us-east-1a  
  map_public_ip_on_launch = true
  
  tags = {
    Name = var.subnet_names[count.index]
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyInternetGateway"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0" # public 
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name" = "MyRouteTable"
  }
}

# Route Table Association
resource "aws_route_table_association" "rta" {
  count = length(var.subnet_cidr)
  subnet_id      = aws_subnet.subnets[count.index].id
  route_table_id = aws_route_table.rt.id
}
variable "vpc_cidr" {
  description = "VPC CIDR Range"
  type = string
  default =  "10.0.0.0/16"
}

variable "subnet_cidr" {
    description = "Subnet CIDRS"
    type = list(string)
    default =  [ "10.0.1.0/24", "10.0.2.0/24" ]
}
