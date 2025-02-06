variable "environment" {
  description = "Ambiente de execução (local ou production)"
  type        = string
  default     = "production"
}

variable "aws_region" {
  description = "Região de disponibilidade da AWS"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
  default = "ASIAV5ZCLZ2UWFOC6W4M"
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true  
  default = "cOx8qqjzTrGkLbI+4eXHJHO8SIzCv+lN9ZXvr3KB"
}

variable "aws_endpoint" {
  description = "Endpoint para criação dos recursos na AWS"
  type        = string
  default     = ""
}

variable iam_labrole_arn {
  type    = string
  description = "ARN do LabRole disponibilizado pela FIAP."  
  default = "arn:aws:iam::407557099177:role/LabRole"
}

variable "availability_zones" {
  type        = list(string)
  description = "Lista de Availability Zones para distribuir as subnets."
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block da VPC principal."
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidrs" {
  type    = list(string)
  default = ["10.0.101.0/24", "10.0.102.0/24"]
}