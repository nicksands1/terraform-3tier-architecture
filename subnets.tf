resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.cidr_block[count.index]
  availability_zone = var.az[count.index]
  count             = 2
}

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1a"
}

data "aws_subnets" "subnet_id" {
  filter {
    name   = "vpc-id"
    values = [aws_vpc.main.id]
  }
}