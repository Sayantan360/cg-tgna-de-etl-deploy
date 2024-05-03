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

variable "vcenter_user" {}

module  "tf-state" {
    source = "./modules/tf-state"
    bucket_name = env.bucket_name
}