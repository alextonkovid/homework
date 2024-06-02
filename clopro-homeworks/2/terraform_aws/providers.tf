terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = var.default_zone
  access_key = var.access_key 
  secret_key = var.secret_key
}