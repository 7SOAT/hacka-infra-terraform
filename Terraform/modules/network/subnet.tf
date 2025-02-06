resource "aws_subnet" "public" {
    count             = length(var.public_subnets_cidrs)
    vpc_id            = aws_vpc.main.id
    cidr_block        = var.public_subnets_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]

    tags = {
      Name = "subnet-public${count.index + 1}-${var.availability_zones[count.index]}"
      Type = "public"
    }

    depends_on = [ aws_vpc.main ]
}

resource "aws_subnet" "private" {
    count                   = length(var.private_subnets_cidrs)
    vpc_id                  = aws_vpc.main.id
    cidr_block              = var.private_subnets_cidrs[count.index]
    availability_zone       = var.availability_zones[count.index]
    map_public_ip_on_launch = false

    tags = {
      Name = "subnet-private${count.index + 1}-${var.availability_zones[count.index]}"   
      Type = "private"
    }

    depends_on = [ aws_vpc.main ]
}