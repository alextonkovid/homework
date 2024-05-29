# Create Subnets
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.netology_vpc.id
  cidr_block        = var.public_subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.netology_vpc.id
  cidr_block = var.private_subnet_cidr

  tags = {
    Name = "private"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "netology_gateway" {
  vpc_id = aws_vpc.netology_vpc.id

  tags = {
    Name = "netology_gateway"
  }
}

# Create Route Tables
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.netology_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netology_gateway.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.netology_vpc.id

  tags = {
    Name = "private_route_table"
  }
}

# Associate Route Tables with Subnets
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# Create NAT Gateway
resource "aws_eip" "nat_eip" {}

resource "aws_nat_gateway" "netology_nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "netology_nat"
  }
}

# Create route for private subnet to use NAT Gateway
resource "aws_route" "private_nat_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.netology_nat.id
}

