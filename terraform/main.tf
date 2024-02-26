terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.38.0"
    }
  }

  backend "s3" {
    bucket = "dunkman.me-terraform"
    key = "state"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}

provider "aws" {
  region = "us-east-1"
}
