resource "aws_s3_bucket" "frame_extractor" {
  bucket = var.frame_extractor_s3_bucket
}

resource "aws_s3_bucket" "lambda_functions" {
  bucket = var.lambda_functions_s3_folder
}