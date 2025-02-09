variable "environment" {
  description = "Ambiente de execução (local ou production)"
  type        = string  
}

variable iam_labrole_arn {
  type = string
}

variable "eks_security_groups_ids" {
  type    = list(string)  
}

variable "eks_cluster_subnets_ids" {
  type    = list(string)  
}

variable "frame_extractor_queue_name" {
  type    = string
  description = "Nome da fila de processamento de videos."
  default = "afluga-hacka-video-processing"
}

variable "notification_queue_name" {
  type    = string
  description = "Nome da fila de processamento de videos."
  default = "afluga-hacka-notification"
}

variable "cognito_redirect_uri" {
  type = string
  description = "URL default para redirecionamento para o frontend."
  default = "https://google.com"
}