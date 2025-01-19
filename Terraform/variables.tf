variable "environment" {
  description = "Ambiente de execução (local ou production)"
  type        = string
  default     = "local"
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
  default     = "local_access_key"
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
  default     = "local_secret_key"
}

variable "aws_endpoint" {
  description = "Endpoint para criação dos recursos na AWS"
  type        = string
  default     = "http://localhost:4566"
}
