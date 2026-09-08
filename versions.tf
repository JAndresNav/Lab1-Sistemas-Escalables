terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }

  # Remote state stored in the shared S3 bucket, so the whole team reads/writes
  # the same terraform.tfstate instead of everyone having their own local copy.
  backend "s3" {
    bucket       = "744998"
    key          = "lab1/terraform.tfstate"
    region       = "us-east-1"
    profile      = "academy"
    encrypt      = true
    use_lockfile = true # native S3 locking (Terraform >= 1.10), no DynamoDB table needed
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}
