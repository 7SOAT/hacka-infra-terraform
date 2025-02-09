resource "aws_eks_cluster" "application" {
  name     = "application-cluster"
  role_arn = var.iam_labrole_arn
  version  = "1.32"

  vpc_config {
    security_group_ids = var.eks_security_groups_ids
    subnet_ids         = var.eks_cluster_subnets_ids
  }
}

resource "aws_eks_node_group" "api" {
  cluster_name    = aws_eks_cluster.application.name
  node_group_name = "apis-node-group"
  node_role_arn   = var.iam_labrole_arn
  subnet_ids      = var.eks_cluster_subnets_ids
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

}

resource "aws_eks_node_group" "consumer" {
  cluster_name    = aws_eks_cluster.application.name
  node_group_name = "consumer-node-group"
  node_role_arn   = var.iam_labrole_arn
  subnet_ids      = var.eks_cluster_subnets_ids
  instance_types = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

}