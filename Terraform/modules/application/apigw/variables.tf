variable "environment" {
  description = "Ambiente de execução (local ou production)"
  type        = string
  default     = "local"
}

variable "frame_extractor_cognito_pool_arn" {
  type = string
}