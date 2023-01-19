# Neworking VPC And Subnets

# Crate a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, {
    Name = var.vpc_name
  })
}



# Create Subnets
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr
  tags = merge(var.tags, {
    Name = var.subnet_name
  })
}



# IGW 
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.main.id
  tags = merge(var.tags, {
    Name = "${var.vpc_name}-IGW"
  })
}



# RT
# Adding route for Internet GateWay
resource "aws_route_table" "mainrt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = merge(var.tags, {
    Name = "RT-${var.vpc_name}-TF"
  })

}


// Assosiate subnets with route table that has IGW - Making subnets public
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.mainrt.id
}