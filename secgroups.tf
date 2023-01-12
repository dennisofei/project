# Security Group for ALB

resource "aws_security_group" "Load-Sec-Grp"{
  name        = "Load-Sec-Grp"
  description = "Allow internet traffic to ALB"
  vpc_id      = aws_vpc.finalpro.id

  ingress {
    description      = "Allow Https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    /* cidr_blocks      = [aws_vpc.finalpro.cidr_block] */
    /* ipv6_cidr_blocks = [aws_vpc.finalpro.ipv6_cidr_block] */
  }


    ingress {
    description      = "Allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    /* cidr_blocks      = [aws_vpc.finalpro.cidr_block] */
    /* ipv6_cidr_blocks = [aws_vpc.finalpro.ipv6_cidr_block] */
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
    /* ipv6_cidr_blocks = ["::/0"] */
  }

  tags = {
    Name = "allow_tls"
  }
}




# Security Group for Container

resource "aws_security_group" "ECS-Sec-Grp" {
  name        = "ECS-Sec-Grp"
  description = "Allow traffic from ALB to Container"
  vpc_id      = aws_vpc.finalpro.id

  ingress {
    description      = "Allow Https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_groups = [aws_security_group.Load-Sec-Grp.id]
    /* cidr_blocks      = [aws_vpc.finalpro.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.finalpro.ipv6_cidr_block] */
  }


    ingress {
    description      = "Allow http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups = [aws_security_group.Load-Sec-Grp.id]
    /* cidr_blocks      = [aws_vpc.finalpro.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.finalpro.ipv6_cidr_block] */
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    /* ipv6_cidr_blocks = ["::/0"] */
  }

  tags = {
    Name = "allow_tls"
  }
}