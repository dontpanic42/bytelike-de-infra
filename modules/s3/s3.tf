resource "aws_s3_bucket" "site_file_bucket" {
  bucket = var.page_domain_name
  acl    = "private"

  # Enable server side encryption
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = merge(var.resource_tags, {
    "Name" = "${var.page_domain_name}"
  })
}