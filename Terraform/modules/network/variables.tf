variable "availability_zones" {
  type        = list(string)
  description = "Lista de Availability Zones para distribuir as subnets"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block da VPC principal."
}

variable "public_subnets_cidrs" {
  type    = list(string)
}

variable "private_subnets_cidrs" {
  type    = list(string)
}
