locals {
  # Some unique identifier for the origin in our cf. Since we only have one, the id does
  # not really matter...
  cf_origin_id = "${var.page_domain_name}-origin-id"
}

# The actual cloudfront distiribution
resource "aws_cloudfront_distribution" "s3_distribution" {

  # Bucket definition
  origin {
    domain_name = var.bucket_domain_name
    origin_id   = local.cf_origin_id

    # We want CF to use our access identity so we can restrict access to our s3 bucket
    s3_origin_config {
      origin_access_identity = var.cf_oai_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.page_domain_name]

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.cf_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 3600
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # PriceClass_100 is the cheapest...
  price_class = "PriceClass_100"

  tags = var.resource_tags

  # We need to tell cloudfront to use our custom cert
  viewer_certificate {
    acm_certificate_arn      = var.acm_cert_arn
    minimum_protocol_version = "TLSv1.2_2018"
    ssl_support_method       = "sni-only"
  }
}

# Get our route53 hosted zone so we can add the alias records
data "aws_route53_zone" "zone" {
  name         = "${var.page_domain_name}."
  private_zone = false
}

# Create alias record for the cloudfront distribution (IPv4)
resource "aws_route53_record" "alias_record_ipv4" {
  name    = var.page_domain_name
  type    = "A"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

# Create alias record for the cloudfront distribution (IPv6)
resource "aws_route53_record" "alias_record_ipv6" {
  name    = var.page_domain_name
  type    = "AAAA"
  zone_id = data.aws_route53_zone.zone.id

  alias {
    name                   = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}