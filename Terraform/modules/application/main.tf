module "sqs-queues" {
  source = "./sqs-queues"
}

module "apigw" {
  source = "./apigw"
  frame_extractor_cognito_pool_arn = var.environment == "production" ? module.cognito[0].frame_extractor_cognito_pool_arn : ""
  environment = var.environment
}

module "cognito" {
  source = "./cognito"

  count = var.environment == "production" ? 1 : 0
}