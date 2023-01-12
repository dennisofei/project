
resource "aws_internet_gateway" "finalpro-igw" {
  vpc_id = aws_vpc.finalpro.id

  tags = {
    Name = "finalpro-igw"
  }
}
