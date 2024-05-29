resource "aws_instance" "netology_instance" {
  ami           = "ami-01974e77aa2dcb43d" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public.id
  key_name = "terraform_ec2_key"
  tags = {
    Name = "netology_instance"
  }

  security_groups = [aws_security_group.netology_security_group.id]
}

resource "aws_key_pair" "terraform_ec2_key" {
	key_name = "terraform_ec2_key"
	public_key = "${file("/home/alex/.ssh/id_ed25519.pub")}"
}

resource "aws_instance" "netology_instance_private" {
  ami           = "ami-01974e77aa2dcb43d" 
  instance_type = "t2.micro"
  subnet_id = aws_subnet.private.id
  key_name = "terraform_ec2_key"
  tags = {
    Name = "netology_instance_private"
  }

  security_groups = [aws_security_group.netology_security_group.id]
}
