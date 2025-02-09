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
#region [RESOURCES]
resource "aws_api_gateway_resource" "v1" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  parent_id   = aws_api_gateway_rest_api.backend.root_resource_id
  path_part   = "v1"
}
#endregion

#region [METHODS]
# Criando um método ANY na raiz para evitar erro "The REST API doesn't contain any methods"
resource "aws_api_gateway_method" "root_any" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_rest_api.backend.root_resource_id
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "v1_any" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_resource.v1.id
  http_method   = "ANY"
  authorization = "NONE"
}
#endregion

#region [INTEGRATIONS]
# Integração MOCK para a raiz "/"
resource "aws_api_gateway_integration" "root_mock" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_rest_api.backend.root_resource_id
  http_method   = aws_api_gateway_method.root_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Integração MOCK para "/v1"
resource "aws_api_gateway_integration" "mock" {
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  resource_id   = aws_api_gateway_resource.v1.id
  http_method   = aws_api_gateway_method.v1_any.http_method
  type          = "MOCK"

  request_templates = {
    "application/json" = jsonencode({ statusCode = 200 })
  }
}

# Resposta para a integração da raiz "/"
resource "aws_api_gateway_integration_response" "root_mock" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  resource_id = aws_api_gateway_rest_api.backend.root_resource_id
  http_method = aws_api_gateway_method.root_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso (ROOT)" })
  }

  depends_on = [aws_api_gateway_integration.root_mock]
}

# Resposta para a integração "/v1"
resource "aws_api_gateway_integration_response" "mock" {
  rest_api_id = aws_api_gateway_rest_api.backend.id
  resource_id = aws_api_gateway_resource.v1.id
  http_method = aws_api_gateway_method.v1_any.http_method
  status_code = "200"

  response_templates = {
    "application/json" = jsonencode({ message = "API Gateway provisionado com sucesso" })
  }

  depends_on = [aws_api_gateway_integration.mock]
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
    aws_api_gateway_integration.root_mock,
    aws_api_gateway_integration.mock,
    aws_api_gateway_integration_response.root_mock,
    aws_api_gateway_integration_response.mock,
    aws_api_gateway_method.root_any
  ]
}
#endregion
#region [STAGES]
resource "aws_api_gateway_stage" "backend" {
  deployment_id = aws_api_gateway_deployment.backend.id
  rest_api_id   = aws_api_gateway_rest_api.backend.id
  stage_name    = "prd"
}
#endregion