resource "aws_vpc" "vpc" {

  cidr_block       = var.vpc_cidr
  instance_tenancy = default

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc"
  }
  
}
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
    Name = "${var.project_name}-${var.environment}-igw"
  }
}
###from data source to take az
data "aws_availability_zone" "available_zones" {}

resource "aws_subnet_az1" "public" {
    vpc_id = var.vpc_cidr
    cidr_block = var.public_subnet_az1_cidr
    map_public_ip_on_launch = true //it makes this a public subnet
    availability_zone = data.aws_availability_zone.available_zones[0]
    tags= {
        Name = "${var.project_name}-${var.environment}-public_subnet_az1"
    }
  
}

resource "aws_subnet_az2" "public" {
    vpc_id = var.vpc_cidr
    cidr_block = var.public_subnet_az2_cidr
    map_public_ip_on_launch = true  //it makes this a public subnet
    availability_zone = data.aws_availability_zone.available_zones[1]
    tags ={
        Name = "${var.project_name}-${var.environment}-public_subnet_az2"
    }
  
}

##### route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_cidr

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-public-rt"
  }
}

# associate public subnet az1 to "public route table"
resource "aws_route_table_association" "public_subnet_az1_rt_association" {
  subnet_id      = aws_subnet.public.1.id
  route_table_id = aws_route_table.public_route_table.id
}

# associate public subnet az2 to "public route table"
resource "aws_route_table_association" "public_subnet_2_rt_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public_route_table.id
}

# create private app subnet az1
resource "aws_subnet" "private_app_subnet_az1" {
  vpc_id                  = var.vpc_cidr
  cidr_block              = var.pvt_subnet_az2_cidr
  availability_zone       = data.aws_availability_zone.available_zones[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-az1"
  }
}

# create private app subnet az2
resource "aws_subnet" "private_app_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_cidr
  availability_zone       = data.aws_availability_zone.available_zones[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-app-az2"
  }
}

# create private data subnet az1
resource "aws_subnet" "private_data_subnet_az1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_cidr
  availability_zone       = data.aws_availability_zone.available_zones[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.project_name}-${var.environment}-private-data-az1"
  }
}

# create private data subnet az2
resource "aws_subnet" "private_data_subnet_az2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.vpc_cidr
  availability_zone       = data.aws_availability_zone.available_zones[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "$${var.project_name}-${var.environment}-private-data-az2"
  }
}





















