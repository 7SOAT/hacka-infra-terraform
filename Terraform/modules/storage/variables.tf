variable "frame_extractor_s3_bucket" {
  description = "Storage principal para armazenamento dos arquivos."
  type        = string  
  default     = "frame-extractor-storage"
}

# variable "lambda_functions_s3_folder" {
#   description = "Storage principal para armazenamento do código fonte das lambdas."
#   type        = string  
#   default     = "lambda-functions-storage"
# }