resource "aws_s3_bucket" "frame_extractor" {
  bucket = var.frame_extractor_s3_bucket
}