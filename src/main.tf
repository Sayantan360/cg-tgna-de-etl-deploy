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
       key    = "statefile/terraform.tfstate"
       region = "us-east-1"
   }
}

provider "aws" {
  region  = "us-east-1"
}  

variable "bucket_name" {}

module  "s3" {
    source = "./modules/s3"
    bucket_name = var.bucket_name
}

module  "iam" {
    source = "./modules/iam"
}

module  "glue" {
    source = "./modules/glue"
    role = module.iam.glue_role_arn
    path = module.s3.mybucket2

}