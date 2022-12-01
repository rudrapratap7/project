resource "aws_security_group" "private_SG" {
name        = "private-SG"
  description = "Allow all inbound traffic withn vpc"
  vpc_id      = aws_vpc.abhi134.id

  ingress {
    description      = "all traffic from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.abhi134.cidr_block]
}

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all"
  }
}
