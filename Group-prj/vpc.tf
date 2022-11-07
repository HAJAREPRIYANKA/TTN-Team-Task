resource "aws_vpc" "custom_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    name = "custom_vpc"
  }
}



resource "aws_subnet" "public_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet1
  availability_zone = var.az1
  map_public_ip_on_launch = true
  tags = {
    name = "public_subnet1"
  }
}


# public subnet 2
resource "aws_subnet" "public_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.public_subnet2
  availability_zone = var.az2
  map_public_ip_on_launch = true
  tags = {
    name = "public_subnet2"
  }
}


# private subnet 1
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet1
  availability_zone = var.az1

  tags = {
    name = "private_subnet1"
  }
}


# private subnet 2
resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.custom_vpc.id
  cidr_block        = var.private_subnet2
  availability_zone = var.az2

  tags = {
    name = "private_subnet2"
  }
}


# creating internet gateway 
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    name = "igw"
  }
}


# creating route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.custom_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    name = "rt"
  }
}


# tags are not allowed here 
# associate route table to the public subnet 1
resource "aws_route_table_association" "public_rt1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the public subnet 2
resource "aws_route_table_association" "public_rt2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the private subnet 1
resource "aws_route_table_association" "private_rt1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.rt.id
}


# tags are not allowed here 
# associate route table to the private subnet 2
resource "aws_route_table_association" "private_rt2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.rt.id
}



