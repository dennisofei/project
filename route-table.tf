
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.finalpro.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.finalpro-igw.id
  }
}



resource "aws_route_table_association" "pubsub1-route-association" {
  subnet_id      = aws_subnet.public-sub-1.id
  route_table_id = aws_route_table.public-route-table.id
}


resource "aws_route_table_association" "pubsub2-route-association" {
  subnet_id      = aws_subnet.public-sub-2.id
  route_table_id = aws_route_table.public-route-table.id
}



#Create AWS Route

resource "aws_route" "public_igw_route" {
  route_table_id            = aws_route_table.public-route-table.id
  gateway_id                = aws_internet_gateway.finalpro-igw.id
  destination_cidr_block    = "0.0.0.0/0"
  
  
}



resource "aws_route_table" "priv-route-table" {
  vpc_id = aws_vpc.finalpro.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.finalpro-Nat-gateway.id
  }
}


resource "aws_route_table_association" "privsub1-route-association" {
  subnet_id      = aws_subnet.priv-sub-1.id
  route_table_id = aws_route_table.priv-route-table.id
}


resource "aws_route_table_association" "privsub2-route-association" {
  subnet_id      = aws_subnet.priv-sub-2.id
  route_table_id = aws_route_table.priv-route-table.id
}