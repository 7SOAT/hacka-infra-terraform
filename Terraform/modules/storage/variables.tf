variable "videos_s3_bucket" {
  description = "Storage principal para armazenamento dos arquivos."
  type        = string  
  default     = "afluga-hacka-videos-storage"
}

variable "frames_s3_bucket" {
  description = "Storage principal para armazenamento dos arquivos."
  type        = string  
  default     = "afluga-hacka-frames-storage"
}

variable "lambda_functions_s3_folder" {
  description = "Storage principal para armazenamento do código fonte das lambdas."
  type        = string  
  default     = "afluga-hacka-lambda-storage"
}