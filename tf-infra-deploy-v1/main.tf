terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
       bucket = "sayantp-backend"
       key    = "sayantp-backend.tfstate"
       region = "us-east-1"
   }
}   

provider "aws" {
  region  = "us-east-1"
}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  force_destroy = true

#   tags = {
#     Name = "My bucket"
#     Environment = "Dev"
#   }
}
