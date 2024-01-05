variable "target_region" {
  type        = string
  description = "Target AWS region"
  default     = "us-east-1"
}

variable "bucket_sse_map" {
  type        = map(string)
  description = "A map of bucket prefix and SSE configuration"
  default = {
    aladin    = "KMS"
    belle   = "S3"
    charlie = "KMS"
  }
}