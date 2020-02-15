output "bucket_domain_name" {
  description = "Regional domain name of this bucket"
  value       = aws_s3_bucket.site_file_bucket.bucket_regional_domain_name
}