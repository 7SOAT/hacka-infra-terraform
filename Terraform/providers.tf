provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key
  secret_key                  = var.aws_secret_key
  skip_credentials_validation = var.environment == "local" ? true : false
  skip_metadata_api_check     = var.environment == "local" ? true : false
  skip_requesting_account_id  = var.environment == "local" ? true : false
  s3_use_path_style           = var.environment == "local" ? true : false 

  endpoints {
    sqs                     = var.aws_endpoint
    s3                      = var.aws_endpoint
    apigateway              = var.aws_endpoint
    cognitoidentity         = var.aws_endpoint
    cognitoidentityprovider = var.aws_endpoint
    dynamodb                = var.aws_endpoint 
    lambda                  = var.aws_endpoint
    iam                     = var.aws_endpoint 
  }
}