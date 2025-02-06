resource "aws_eip" "main_nat" {
  count = length(var.public_subnets_cidrs)

  tags = {
    Name = "main-nat-eip-${count.index + 1}"
  }
}