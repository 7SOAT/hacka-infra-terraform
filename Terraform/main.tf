terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # backend "s3" {
  #   bucket         = var.state_bucket
  #   key            = "terraform.tfstate"
  #   region         = "us-east-1"
  #   access_key     = var.state_access_key
  #   secret_key     = var.state_secret_key
  #   token          = var.state_session_token
  # }
}