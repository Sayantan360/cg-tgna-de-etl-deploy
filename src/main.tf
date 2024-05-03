terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"

  backend "s3" {
       bucket = "sayantp-backend2"
       key    = "sayantp-backend.tfstate"
       region = "us-east-1"
   }
}

provider "aws" {
  region  = "us-east-1"
}  

variable "bucket_name" {}

module  "tf-state" {
    source = "./modules/tf-state"
    bucket_name = var.bucket_name
}