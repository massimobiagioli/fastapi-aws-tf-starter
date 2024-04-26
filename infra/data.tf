data "aws_ssm_parameter" "app_secret" {
  name            = "app_secret"
  depends_on      = [aws_ssm_parameter.app_secret]
  with_decryption = true
}

data "aws_iam_policy_document" "lambda_exec_role_policy" {
  statement {
    actions = [
      "ssm:GetParameter"
    ]
    resources = [
      data.aws_ssm_parameter.app_secret.arn,
    ]
  }
}