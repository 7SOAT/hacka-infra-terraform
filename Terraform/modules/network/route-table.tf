resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-rtb-public"
  }

  depends_on = [
    aws_vpc.main,
    aws_internet_gateway.main
  ]
}

resource "aws_route_table" "private" {
  count  = length(var.private_subnets_cidrs)
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "main-rtb-private${count.index + 1}-${var.availability_zones[count.index]}"
  }

  depends_on = [ 
    aws_vpc.main,
    aws_nat_gateway.main
  ]
}