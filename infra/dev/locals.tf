locals {
  common_tags = {
    Service = var.service_name
    Owner   = var.owner
    Destroy = "false"
  }
}