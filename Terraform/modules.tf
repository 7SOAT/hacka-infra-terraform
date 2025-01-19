module "application" {
  source = "./modules/application"
  environment = var.environment
}

module "storage" {
  source = "./modules/storage"
}

module "network" {
  source = "./modules/network"
}

module "persistence" {
  source = "./modules/persistence"
}