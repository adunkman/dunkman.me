terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.98.0"
    }
  }

  backend "s3" {
    bucket = "dunkman.me-terraform"
    key = "state"
    region = "us-east-1"
    use_lockfile = true
  }
}

provider "aws" {
  region = "us-east-1"
}
