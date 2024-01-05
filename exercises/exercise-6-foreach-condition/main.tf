resource "aws_s3_bucket" "example" {
  for_each      = var.bucket_sse_map
  bucket_prefix = each.key
}

resource "aws_kms_key" "examplekey" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example_sse" {
  for_each = var.bucket_sse_map
  bucket   = aws_s3_bucket.example[each.key].id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = each.value == "KMS" ? "aws:kms" : "AES256"
      kms_master_key_id = each.value == "KMS" ? aws_kms_key.examplekey.arn : null
    }
  }
}
