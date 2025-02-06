output "vpc_id" {
  value = aws_vpc.main.id
}

output "private_subnets_ids" {
  value = tolist(aws_subnet.private[*].id)
}

output "eks_security_groups_ids" {
  value = [aws_security_group.eks_sg.id]
}

output "nlb_security_groups_ids" {
  value = [aws_security_group.nlb_sg.id]
}