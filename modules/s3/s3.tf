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

# we don't want people to directly access our S3 bucket, so via bucket policy we restrict
# access to the cloudfront origin access identity
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site_file_bucket.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }

  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.site_file_bucket.arn]

    principals {
      type        = "AWS"
      identifiers = [var.oai_iam_arn]
    }
  }
}

# Attach the bucket policy
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.site_file_bucket.id
  policy = data.aws_iam_policy_document.s3_policy.json
}