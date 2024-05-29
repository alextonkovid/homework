resource "aws_security_group" "netology_security_group" {
  name        = "netology_security_group"
  description = "enables SSH and ICMP traffic"
  vpc_id      = aws_vpc.netology_vpc.id
}

resource "aws_security_group_rule" "netology_ssh_rule" {
  type        = "egress"
  from_port   = 22
  to_port   = 22
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.netology_security_group.id
}


resource "aws_security_group_rule" "netology_icmp_rule" {
  type        = "egress"
  protocol   = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = -1
  to_port = -1
  security_group_id = aws_security_group.netology_security_group.id
}

resource "aws_security_group_rule" "netology_ssh_rule_ingress" {
  type        = "ingress"
  from_port   = 22
  to_port   = 22
  protocol   = "tcp"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.netology_security_group.id
}


resource "aws_security_group_rule" "netology_icmp_rule_ingress" {
  type        = "ingress"
  protocol   = "icmp"
  cidr_blocks = ["0.0.0.0/0"]
  from_port = -1
  to_port = -1
  security_group_id = aws_security_group.netology_security_group.id
}