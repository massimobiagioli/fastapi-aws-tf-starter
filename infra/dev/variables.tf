variable "service_name" {
  type        = string
  description = "Service name"
}

variable "owner" {
  type        = string
  description = "Owner of the service"
}

variable "aws_params" {
  type        = map(string)
  description = "AWS parameters"

  default = {
    region                                 = "eu-west-1"
    lambda_runtime                         = "python3.12"
    profile                                = "default"
    cloudwatch_log_group_retention_in_days = 14
  }
}
