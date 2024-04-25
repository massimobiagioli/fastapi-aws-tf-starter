locals {
  owner        = "Massimo Biagioli"
  service_name = "tf-starter"

  layers = {
    fastapi = {
      name                = "fastapi-layer"
      description         = "FastAPI layer"
      compatible_runtimes = ["python3.12"]
    }
  }

  functions = {
    main = {
      name    = "app"
      handler = "app.lambda.handler"
    }
  }

  common_tags = {
    Service = local.service_name
    Owner   = local.owner
    Destroy = "false"
  }
}

variable "aws_params" {
  type        = map(string)
  description = "AWS parameters"

  default = {
    region                                 = "eu-west-1"
    lambda_runtime                         = "python3.12"
    cloudwatch_log_group_retention_in_days = 14
  }
}