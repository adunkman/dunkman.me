terraform {
  backend "s3" {
    bucket = "dunkman.me-terraform"
    key = "state"
    region = "us-east-1"
    dynamodb_table = "terraform"
  }
}

provider "aws" {
  version = "~> 3.0"
  region = "us-east-1"
}
