terraform {
  required_version = ">= 1.7.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Keeps you safely on a stable version release
    }
  }
}

provider "aws" {
  region = "us-east-1" # Feel free to change to your closest region (e.g., us-west-2)

  # Enterprise FinOps Practice: Automatically tags every resource created by this project
  default_tags {
    tags = {
      Environment = "dev"
      Project     = "enterprise-multi-agent-ai-platform"
      ManagedBy   = "Terraform"
    }
  }
}
