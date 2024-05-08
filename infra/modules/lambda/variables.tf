variable "name" {
  description = "Function name"
  type        = string
}

variable "source_dir" {
  description = "Source directory"
  type        = string
}

variable "handler" {
  description = "Handler function"
  type        = string
}

variable "runtime" {
  description = "Runtime"
  type        = string
}

variable "build_dir" {
  description = "Layers directory"
  type        = string
}

variable "layers" {
  description = "Lambda layers"
  type        = list(string)
}

variable "iam_role_name" {
  description = "IAM role name"
  type        = string
}

variable "secret_value" {
  description = "Secret value"
  type        = string
}

variable "secret_arn" {
  description = "Secret ARN"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}