terraform {

  backend "s3" {
    bucket = "rose-devops-tf-state-12345"
    key    = "resume-website/terraform.tfstate"
    region = "us-east-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}


provider "aws" {
  region = "us-east-1"
}