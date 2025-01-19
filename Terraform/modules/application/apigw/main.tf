resource "aws_api_gateway_rest_api" "frame_extractor" {
  name  = "frame-extractor-apigw"
}

resource "aws_api_gateway_rest_api" "user" {
  name  = "user-apigw"
}

resource "aws_api_gateway_authorizer" "frame_extractor" {
  name = "frame-extractor-cognito-auth"
  rest_api_id = aws_api_gateway_rest_api.frame_extractor.id
  type = "COGNITO_USER_POOLS"
  provider_arns = [var.frame_extractor_cognito_pool_arn]

  identity_source = "method.request.header.Authorization"

  count = var.environment == "production" ? 1 : 0
}

resource "aws_api_gateway_authorizer" "user" {
  name = "user-cognito-auth"
  rest_api_id = aws_api_gateway_rest_api.user.id
  type = "COGNITO_USER_POOLS"
  provider_arns = [var.frame_extractor_cognito_pool_arn]

  identity_source = "method.request.header.Authorization"

  count = var.environment == "production" ? 1 : 0
}