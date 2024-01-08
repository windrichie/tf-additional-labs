resource "aws_s3_bucket" "example" {
  for_each      = var.bucket_sse_map
  bucket_prefix = each.key
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example_sse" {
  for_each = var.bucket_sse_map
  bucket   = aws_s3_bucket.example[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = each.value == "KMS" ? "aws:kms" : "AES256"
    }
  }
}
