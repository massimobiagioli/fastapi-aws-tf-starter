resource "aws_ssm_parameter" "app_secret" {
  lifecycle {
    ignore_changes = [value]
  }

  type  = "SecureString"
  name  = "app_secret"
  value = "k1=v1\nk2=v2"

  tags = local.common_tags
}