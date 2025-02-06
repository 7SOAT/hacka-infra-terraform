resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
      Name = "main-igw"
  }

  depends_on = [ aws_vpc.main ]
}

resource "aws_nat_gateway" "main" {
    count         = length(var.public_subnets_cidrs)
    allocation_id = aws_eip.main_nat[count.index].id
    subnet_id     = aws_subnet.public[count.index].id

    tags = {
      Name = "main-nat-gateway-${count.index + 1}"
    }

    depends_on = [ 
      aws_eip.main_nat, 
      aws_subnet.public
    ]
}