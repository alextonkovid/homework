# Security Group
resource "aws_security_group" "netology_security_group" {
  name        = "netology_security_group"
  description = "enables SSH and ICMP traffic"
  vpc_id      = aws_vpc.netology_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "netology_security_group"
  }
}
