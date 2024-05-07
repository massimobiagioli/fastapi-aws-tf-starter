resource "null_resource" "package_lambda" {
  provisioner "local-exec" {
    command = "cd ${path.module}/.. && scripts/package_lambda.sh"
  }
}

resource "aws_lambda_function" "app" {
  filename      = "${path.module}/../build/lambda/lambda.zip"
  function_name = var.function_name
  role          = aws_iam_role.iam_for_app.arn
  depends_on    = [null_resource.package_lambda]
  handler       = var.handler
  layers        = var.layers
  runtime       = var.runtime
  environment {
    variables = {
      for pair in split("\n", var.secret_value) :
      split("=", pair)[0] => split("=", pair)[1]
    }
  }

  tags = var.tags
}

resource "aws_iam_role" "iam_for_app" {
  name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function_url" "app" {
  function_name      = aws_lambda_function.app.function_name
  authorization_type = "NONE"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}
