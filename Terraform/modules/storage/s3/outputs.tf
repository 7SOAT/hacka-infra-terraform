output "frame_extractor_bucket" {
  value = aws_s3_bucket.frame_extractor.bucket
}

output "lambda_functions_bucket" {
  value = aws_s3_bucket.lambda_functions.bucket
}