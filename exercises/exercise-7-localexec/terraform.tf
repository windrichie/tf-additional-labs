terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "tf-state-20240103075457355800000001"
    dynamodb_table = "tf-lock"
    key            = "terraform-state-additional.tfstate"
    region         = "us-east-1"
  }


  required_providers {
    aws = {
      version = "4.45"
    }
  }
}

provider "aws" {
  region = var.target_region
}