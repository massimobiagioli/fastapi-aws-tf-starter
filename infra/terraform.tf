terraform {
  required_providers {
    aws = {
      version = ">= 5.46.0"
      source  = "hashicorp/aws"
    }
  }

  required_version = "~> 1.0"

  backend "s3" {
    bucket         = "tfstate-fastapi-aws-tf-starter"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "terraform-locking"
  }
}