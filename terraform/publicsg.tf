resource "aws_security_group" "Public-web_SG" {
  name        = "Public-web_SG"
  description = "Allow port 80 form self ip"
  vpc_id      = [aws_vpc.abhi134.id]

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "HTTP"
    cidr_blocks      = ["49.43.42.187/32"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow http"
  }
}
