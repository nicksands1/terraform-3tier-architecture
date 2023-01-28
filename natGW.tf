resource "aws_nat_gateway" "natGW" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.igw]
}