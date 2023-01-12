# Elastic IP
resource "aws_eip" "EIP_for_NG" {
  vpc = true
  associate_with_private_ip = "10.0.0.4"
  depends_on = [
    aws_internet_gateway.finalpro-igw
  ]
}


# NAT Gateway resource
resource "aws_nat_gateway" "finalpro-Nat-gateway" { 
allocation_id = aws_eip.EIP_for_NG.id 
subnet_id = aws_subnet.public-sub-1.id
} 
