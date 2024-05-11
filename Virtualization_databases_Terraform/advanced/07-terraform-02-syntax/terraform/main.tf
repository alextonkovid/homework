# Create a VPC
resource "aws_vpc" "netology" {
  cidr_block = "172.16.0.0/24"
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.netology.id
} 
resource "aws_subnet" "netology_subnet" {
  vpc_id            = aws_vpc.netology.id
  cidr_block        = "172.16.0.0/24"  # Adjusted CIDR block
  availability_zone = "eu-central-1c"

  tags = {
    Name = "netology"
  }
}
resource "aws_eip" "netology_terraform" {
  instance = aws_instance.netology_terraform.id
  vpc      = true
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


resource "aws_instance" "netology_terraform" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.netology_subnet.id
  private_ip    = "172.16.0.10"
  availability_zone = "eu-central-1c"

  tags = {
    Name = "HelloWorld"
  }
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

