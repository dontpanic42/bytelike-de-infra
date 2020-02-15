resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin access identity to match CF distribution in Bucket Policy"
}