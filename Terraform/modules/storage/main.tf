module "s3" {
  source = "./s3"  
  frame_extractor_s3_bucket = var.frame_extractor_s3_bucket
  lambda_functions_s3_folder = var.lambda_functions_s3_folder
}