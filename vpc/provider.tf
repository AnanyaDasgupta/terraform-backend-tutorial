terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 4.66.1"
    }
  }
}

provider "aws" {
  region              = "ap-south-1"
  allowed_account_ids = [local.aws_account_id]
}