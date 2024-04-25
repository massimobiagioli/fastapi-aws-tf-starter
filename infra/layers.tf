resource "null_resource" "package_layers" {
  triggers = {
    requirements = filesha1("${path.module}/../requirements/requirements_dev.txt")
  }
  provisioner "local-exec" {
    command = "cd ${path.module}/.. && ./scripts/package_layers.sh"
  }
}

resource "aws_s3_bucket" "layer_fastapi" {
  bucket_prefix = "layer"

  tags = local.common_tags
}

resource "aws_s3_object" "layer_fastapi_zip" {
  bucket     = aws_s3_bucket.layer_fastapi.id
  key        = "layer_fastapi.zip"
  source     = "${path.module}/../build/layers/fastapi_layer.zip"
  depends_on = [null_resource.package_layers]

  tags = local.common_tags
}

resource "aws_lambda_layer_version" "lambda_layer_fastapi" {
  s3_bucket           = aws_s3_bucket.layer_fastapi.id
  s3_key              = aws_s3_object.layer_fastapi_zip.key
  layer_name          = local.layers.fastapi.name
  compatible_runtimes = local.layers.fastapi.compatible_runtimes
  description         = local.layers.fastapi.description
  skip_destroy        = true
  depends_on          = [aws_s3_object.layer_fastapi_zip]
}