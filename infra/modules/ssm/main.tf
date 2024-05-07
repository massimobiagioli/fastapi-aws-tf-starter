resource "aws_ssm_parameter" "app_secret" {
  lifecycle {
    ignore_changes = [value]
  }

  type  = "SecureString"
  name  = var.name
  value = "k1=v1\nk2=v2"

  tags = var.tags
}