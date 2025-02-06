module "network" {
  source = "./modules/network"
  availability_zones = var.availability_zones
  vpc_cidr_block = var.vpc_cidr_block
  private_subnets_cidrs = var.private_subnets_cidrs
  public_subnets_cidrs = var.public_subnets_cidrs
}

module "application" {
  source = "./modules/application"
  environment = var.environment
  eks_cluster_subnets_ids = module.network.private_subnets_ids
  eks_security_groups_ids = module.network.eks_security_groups_ids  
  iam_labrole_arn = var.iam_labrole_arn
  depends_on = [ module.network ]
}

module "storage" {
  source = "./modules/storage"

  depends_on = [ module.network ]
}

module "persistence" {
  source = "./modules/persistence"

  depends_on = [ module.network ]
}

module "identity" {
  source = "./modules/identity"

  depends_on = [ module.network ]
}