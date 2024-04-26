resource "null_resource" "package_lambda" {
  provisioner "local-exec" {
    command = "cd ${path.module}/.. && scripts/package_lambda.sh"
  }
}

resource "aws_lambda_function" "app" {
  filename      = "${path.module}/../build/lambda/lambda.zip"
  function_name = "app"
  role          = aws_iam_role.iam_for_app.arn
  depends_on    = [null_resource.package_lambda]
  handler       = "app.lambda.handler"
  layers        = [aws_lambda_layer_version.lambda_layer_fastapi.arn]
  runtime       = "python3.12"
  environment {
    variables = {
      for pair in split("\n", data.aws_ssm_parameter.app_secret.value) :
      split("=", pair)[0] => split("=", pair)[1]
    }
  }

  tags = local.common_tags
}

resource "aws_iam_role" "iam_for_app" {
  name = "iam_for_app"

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
