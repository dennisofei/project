
resource "aws_subnet" "public-sub-1" {
  vpc_id     = aws_vpc.finalpro.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-sub-1"
  }
}


resource "aws_subnet" "public-sub-2" {
  vpc_id     = aws_vpc.finalpro.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "public-sub-2"
  }
}


resource "aws_subnet" "priv-sub-1" {
  vpc_id     = aws_vpc.finalpro.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "privatesub-1"
  }
}


resource "aws_subnet" "priv-sub-2" {
  vpc_id     = aws_vpc.finalpro.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "privatesub-2"
  }
}
