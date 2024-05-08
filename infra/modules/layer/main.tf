resource "null_resource" "package_layers" {
  triggers = {
    requirements = filesha1(var.requirements_file)
  }
  provisioner "local-exec" {
    command = "cd ${path.module} && ./package_layers.sh ${var.name} ${var.requirements_file} ${var.build_dir}"
  }
}

resource "aws_s3_bucket" "layer" {
  bucket_prefix = var.bucket_prefix

  tags = var.tags
}

resource "aws_s3_object" "layer_zip" {
  bucket     = aws_s3_bucket.layer.id
  key        = "${var.name}.zip"
  source     = "${var.build_dir}/${var.name}.zip"
  depends_on = [null_resource.package_layers]

  tags = var.tags
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_bucket           = aws_s3_bucket.layer.id
  s3_key              = aws_s3_object.layer_zip.key
  layer_name          = var.name
  compatible_runtimes = var.compatible_runtimes
  description         = var.description
  skip_destroy        = true
  depends_on          = [aws_s3_object.layer_zip]
}