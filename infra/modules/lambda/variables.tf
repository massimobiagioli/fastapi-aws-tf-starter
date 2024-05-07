variable "function_name" {
  description = "Function name"
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

variable "tags" {
  description = "Tags"
  type        = map(string)
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