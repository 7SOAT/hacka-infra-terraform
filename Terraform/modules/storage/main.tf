module "s3" {
  source = "./s3"
  lambda_functions_s3_bucket = var.lambda_functions_s3_bucket
  frame_extractor_s3_bucket = var.frame_extractor_s3_bucket
}