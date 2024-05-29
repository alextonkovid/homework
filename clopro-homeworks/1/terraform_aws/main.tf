# Create a VPC
resource "aws_vpc" "netology_vpc" {
  cidr_block = "10.0.0.0/16"
}
resource "aws_default_vpc" "netology_vpc" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.netology_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.netology_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "private"
  }
}

resource "aws_internet_gateway" "netology_gateway" {
  vpc_id = aws_vpc.netology_vpc.id

  tags = {
    Name = "Netology_gateway"
  }
}

resource "aws_route_table" "netology_route_table" {

  vpc_id = aws_vpc.netology_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netology_gateway.id
  }

  tags = {
    Name = "netology_route_table"
  }
}
resource "aws_route_table" "netology_route_table_private" {

  vpc_id = aws_vpc.netology_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.netology_nat.id
  }

  tags = {
    Name = "netology_route_table_private"
  }
}

resource "aws_route_table_association" "netology_route_table_assoc" {

  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.netology_route_table.id

}

resource "aws_route_table_association" "netology_nat_gateway_assoc_private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.netology_route_table.id
}

resource "aws_nat_gateway" "netology_nat" {
  connectivity_type = "private"
  subnet_id         = aws_subnet.public.id
}