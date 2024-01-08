resource "aws_s3_bucket" "example" {
  for_each      = var.bucket_sse_map
  bucket_prefix = each.key

  provisioner "local-exec" {
    when = destroy
    command = <<EOT
        aws s3 rm s3://${self.id} --recursive
    EOT
  }
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

resource "null_resource" "upload_objects" {
  for_each = var.bucket_sse_map

  provisioner "local-exec" {
    when = create
    command = "aws s3 cp files/ s3://${aws_s3_bucket.example[each.key].id} --recursive"
  }
}
