resource "aws_s3_bucket" "videos" {
  bucket = var.videos_s3_bucket
}

resource "aws_s3_bucket" "frames" {
  bucket = var.frames_s3_bucket
}

# resource "aws_s3_bucket" "lambda_functions" {
#   bucket = var.lambda_functions_s3_folder
# }