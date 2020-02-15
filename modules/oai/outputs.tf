output "iam_arn" {
  description = "ARN for use in S3 bucket policies"
  value       = aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn
}

output "cf_oai_path" {
  description = "Full path for the origin access identity to be used by CF"
  value       = aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path
}