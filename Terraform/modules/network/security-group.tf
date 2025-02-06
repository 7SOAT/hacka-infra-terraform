resource "aws_security_group" "eks_sg" {
  name_prefix = "eks-sg-"
  vpc_id      = aws_vpc.main.id

  # Permitir tráfego do NLB para os nodes
  ingress {
    from_port   = 80  # 🔹 Porta onde sua API roda no EKS
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.nlb_sg.id]
    description = "Permitir trafego do Load Balancer para os Nodes do EKS (NodePort)"
  }

  # Permitir saída para a Internet (NAT Gateway necessário para subnet privada)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Permitir saida para a internet"
  }

  tags = {
    Name = "eks-sg"
  }
}

resource "aws_security_group" "nlb_sg" {
  name_prefix = "nlb-sg-"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # 🔹 Se quiser expor para o mundo, ou especifique um IP específico
    description = "Permitir trafego HTTP para o Load Balancer"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
    description = "Permitir trafego HTTPS para o Load Balancer"
  }

  tags = {
    Name = "nlb-sg"
  }
}