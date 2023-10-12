variable "bucket_name" {
  type        = string
  default     = null
}

variable "region" {
  type        = string
  description = "AWS Region"
}

variable "application_id" {
  type        = string
}

variable "environment" {
  type = string
}

variable "block_public_access" {
  type    = bool
  default = true
}

variable "bucket_access_roles" {
  type        = list(string)
  description = "List of arn roles that will be granted read access to the bucket"
  default     = []
}