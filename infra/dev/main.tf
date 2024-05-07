provider "aws" {
  region  = var.aws_params["region"]
  profile = var.aws_params["profile"]
}

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

module "ssm" {
  source = "../modules/ssm"

  name = "app_secret"
  tags = local.common_tags
}

module "layer_fastapi" {
  source = "../modules/layer"

  requirements_file   = "${path.module}/requirements_fastapi.txt"
  name                = "fastapi"
  description         = "FastAPI layer"
  compatible_runtimes = ["python3.12"]
  bucket_prefix       = "layer"
  build_dir           = "../build/layers"
  tags                = local.common_tags
}

module "lambda" {
  source = "../modules/lambda"

  function_name = "app"
  handler       = "app.lambda.handler"
  runtime       = "python3.12"
  layers        = [module.layer_fastapi.layer_arn]
  iam_role_name = "iam_for_app"
  secret_value  = module.ssm.secret_value
  secret_arn    = module.ssm.secret_arn
  tags          = local.common_tags
}