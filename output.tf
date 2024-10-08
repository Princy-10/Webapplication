# export the region
output "region" {
  value = var.region
}

# export the project name
output "project_name" {
  value = var.project_name
}

# export the environment
output "environment" {
  value = var.environment
}

# export the vpc id
output "vpc_id" {
  value = aws_vpc.vpc
}

# export the internet gateway
output "internet_gateway" {
  value = aws_internet_gateway.igw
}

# export the public subnet az1 id
output "public_subnet_az1_id" {
  value = aws_subnet_az1.public
}

# export the public subnet az2 id
output "public_subnet_az2_id" {
  value = aws_subnet_az2.public 
}

# export the private app subnet az1 id
output "private_app_subnet_az1_id" {
  value = aws_subnet.private_app_subnet_az1
}

# export the private app subnet az2 id
output "private_app_subnet_az2_id" {
  value =aws_subnet.private_app_subnet_az2 
}

# export the private data subnet az1 id
output "private_data_subnet_az1_id" {
  value = aws_subnet.private_data_subnet_az1
}

# export the private data subnet az2 id
output "private_data_subnet_az2_id" {
  value = aws_subnet.private_data_subnet_az1
}

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zone.available_zones.names[0]
}

# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zone.available_zones.names[1]
}