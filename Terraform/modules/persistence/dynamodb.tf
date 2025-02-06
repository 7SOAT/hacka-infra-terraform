resource "aws_dynamodb_table" "videos" {
  name           = var.videos_table_name
  billing_mode   = "PAY_PER_REQUEST"  
  hash_key       = "videoId"
  range_key      = "userId"

  attribute {
    name = "videoId"
    type = "S"
  }

  attribute {
    name = "userId"
    type = "S"
  }

  ttl {
    attribute_name = "ttl"
    enabled        = true
  }

  global_secondary_index {
    name               = "userId-index"
    hash_key           = "userId"    
    projection_type    = "INCLUDE"
    non_key_attributes = ["videoId"]
  }
}