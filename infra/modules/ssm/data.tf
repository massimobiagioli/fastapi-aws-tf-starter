data "aws_ssm_parameter" "app_secret" {
  name            = var.name
  depends_on      = [aws_ssm_parameter.app_secret]
  with_decryption = true
}