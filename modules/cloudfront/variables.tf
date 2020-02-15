variable "page_domain_name" {
  description = "domain name of the webiste (eg. bytelike.com)"
  type        = string
}

variable "bucket_domain_name" {
  description = "Regional domain name of the s3 bucket that is the origin for this cf distribution"
  type        = string
}

variable "acm_cert_arn" {
  description = "ARN of the ACM Certificate to use"
  type        = string
}

variable "cf_oai_path" {
  description = "Full path for the origin access identity to use"
  type        = string
}

variable "resource_tags" {
  description = "Tags attached to all resources"
  type        = map(string)
}