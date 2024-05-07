output "secret_value" {
  value = aws_ssm_parameter.app_secret.value
}

output "secret_arn" {
  value = aws_ssm_parameter.app_secret.arn
}