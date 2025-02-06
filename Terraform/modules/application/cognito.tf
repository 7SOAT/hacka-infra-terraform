# resource "aws_cognito_user_pool" "frame_extractor" {
#   name = "frame-extractor-user-pool"
# }

# resource "aws_cognito_user_pool_client" "frame_extractor" {
#   name                = "frame-extractor-app-client"
#   user_pool_id        = aws_cognito_user_pool.frame_extractor.id

#   explicit_auth_flows = ["ALLOW_USER_PASSWORD_AUTH", "ALLOW_REFRESH_TOKEN_AUTH"]
#   generate_secret     = false
# }