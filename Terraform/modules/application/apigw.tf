#region [REST APIs]
resource "aws_api_gateway_rest_api" "backend" {
  name        = "backend-apigw"
  description = "Backend services API Gateway used for EKS. Managed by Terraform."
  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = {
    Name = "backend-apigw"
  }
}

resource "aws_api_gateway_rest_api" "bff" {
  name        = "bff-apigw"
  description = "BFF service API Gateway used for EKS. Managed by Terraform."
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
#endregion
#region [Cloudwatch]
resource "aws_cloudwatch_log_group" "backend" {
  name              = "/aws/apigateway/backend-api"
  retention_in_days = 7
}
resource "aws_cloudwatch_log_group" "bff" {
  name              = "/aws/apigateway/bff-api"
  retention_in_days = 7
}
#endregion
#region [ACCOUNT]
resource "aws_api_gateway_account" "backend" {
  cloudwatch_role_arn = var.iam_labrole_arn
}

resource "aws_api_gateway_account" "bff" {
  cloudwatch_role_arn = var.iam_labrole_arn
}
#endregion
#region [RESOURCES]
resource "aws_api_gateway_resource" "backend_v1" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  parent_id   = aws_api_gateway_rest_api.backend.root_resource_id
  path_part   = "v1"
}
resource "aws_api_gateway_resource" "bff_v1" {
  rest_api_id = aws_api_gateway_rest_api.bff.id
  parent_id   = aws_api_gateway_rest_api.bff.root_resource_id
  path_part   = "v1"
}
#endregion
#region [METHODS]
# Criando um método ANY na raiz para evitar erro "The REST API doesn't contain any methods"
resource "aws_api_gateway_method" "backend_root_any" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_rest_api.backend.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "backend_v1_any" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_resource.backend_v1.id
  http_method   = "ANY"
  authorization = "NONE"

}

resource "aws_api_gateway_method" "bff_root_any" {
  rest_api_id   = aws_api_gateway_rest_api.bff.id
  resource_id   = aws_api_gateway_rest_api.bff.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "bff_v1_any" {
  rest_api_id   = aws_api_gateway_rest_api.bff.id
  resource_id   = aws_api_gateway_resource.bff_v1.id
  http_method   = "ANY"
  authorization = "NONE"
}
#endregion
#region [INTEGRATIONS]
# Integração MOCK para a raiz "/"
resource "aws_api_gateway_integration" "backend_root_mock" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_rest_api.backend.root_resource_id
  http_method   = aws_api_gateway_method.backend_root_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Integração MOCK para "/v1"
resource "aws_api_gateway_integration" "backend_mock" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_resource.backend_v1.id
  http_method   = aws_api_gateway_method.backend_v1_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Resposta para a integração da raiz "/"
resource "aws_api_gateway_integration_response" "backend_root_mock" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  resource_id = aws_api_gateway_rest_api.backend.root_resource_id
  http_method = aws_api_gateway_method.backend_root_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso (ROOT)" })
  }

  depends_on = [aws_api_gateway_integration.backend_root_mock]
}

# Resposta para a integração "/v1"
resource "aws_api_gateway_integration_response" "backend_mock" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  resource_id = aws_api_gateway_resource.backend_v1.id
  http_method = aws_api_gateway_method.backend_v1_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso" })
  }

  depends_on = [aws_api_gateway_integration.backend_mock]
}

resource "aws_api_gateway_integration" "bff_root_mock" {
  rest_api_id   = aws_api_gateway_rest_api.bff.id
  resource_id   = aws_api_gateway_rest_api.bff.root_resource_id
  http_method   = aws_api_gateway_method.bff_root_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Integração MOCK para "/v1"
resource "aws_api_gateway_integration" "bff_mock" {
  rest_api_id   = aws_api_gateway_rest_api.bff.id
  resource_id   = aws_api_gateway_resource.bff_v1.id
  http_method   = aws_api_gateway_method.bff_v1_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Resposta para a integração da raiz "/"
resource "aws_api_gateway_integration_response" "bff_root_mock" {
  rest_api_id = aws_api_gateway_rest_api.bff.id
  resource_id = aws_api_gateway_rest_api.bff.root_resource_id
  http_method = aws_api_gateway_method.bff_root_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso (ROOT)" })
  }

  depends_on = [aws_api_gateway_integration.bff_root_mock]
}

# Resposta para a integração "/v1"
resource "aws_api_gateway_integration_response" "bff_mock" {
  rest_api_id = aws_api_gateway_rest_api.bff.id
  resource_id = aws_api_gateway_resource.bff_v1.id
  http_method = aws_api_gateway_method.bff_v1_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso" })
  }

  depends_on = [aws_api_gateway_integration.bff_mock]
}
#endregion
#region [DEPLOYMENTS]
resource "aws_api_gateway_deployment" "backend" {
  rest_api_id = aws_api_gateway_rest_api.backend.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.backend.body))
    auto_deploy  = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.backend_root_mock,
    aws_api_gateway_integration.backend_mock,
    aws_api_gateway_integration_response.backend_root_mock,
    aws_api_gateway_integration_response.backend_mock,
    aws_api_gateway_method.backend_root_any
  ]
}

resource "aws_api_gateway_deployment" "bff" {
  rest_api_id = aws_api_gateway_rest_api.bff.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.bff.body))
    auto_deploy  = true
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_api_gateway_integration.bff_root_mock,
    aws_api_gateway_integration.bff_mock,
    aws_api_gateway_integration_response.bff_root_mock,
    aws_api_gateway_integration_response.bff_mock,
    aws_api_gateway_method.bff_root_any
  ]
}
#endregion
#region [STAGES]
resource "aws_api_gateway_stage" "backend" {
  deployment_id = aws_api_gateway_deployment.backend.id
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  stage_name    = "prd"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.backend.arn
    format          = "$context.requestId $context.identity.sourceIp $context.httpMethod $context.resourcePath $context.status $context.error.message"
  }
}

resource "aws_api_gateway_stage" "bff" {
  deployment_id = aws_api_gateway_deployment.bff.id
  rest_api_id   = aws_api_gateway_rest_api.bff.id
  stage_name    = "prd"

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.bff.arn
    format          = "$context.requestId $context.identity.sourceIp $context.httpMethod $context.resourcePath $context.status $context.error.message"
  }
}
#endregion