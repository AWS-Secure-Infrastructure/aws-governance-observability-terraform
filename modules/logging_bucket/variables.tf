variable "bucket_name" {
  description = "Name of the logging S3 bucket"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS key ARN for bucket encryption"
  type        = string
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
}
