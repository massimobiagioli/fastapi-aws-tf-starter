variable "requirements_file" {
  description = "Requirements file"
  type        = string
}

variable "name" {
  description = "Layer name"
  type        = string
}

variable "description" {
  description = "Layer description"
  type        = string
}

variable "compatible_runtimes" {
  description = "Compatible runtimes"
  type        = list(string)
}

variable "bucket_prefix" {
  description = "Bucket prefix"
  type        = string
}

variable "build_dir" {
  description = "Layers directory"
  type        = string
}

variable "tags" {
  description = "Tags"
  type        = map(string)
}
