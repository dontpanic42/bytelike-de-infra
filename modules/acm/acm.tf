# Certificate request
resource "aws_acm_certificate" "cert" {
  # For cloudfront the certificate has to be created in us east 1
  provider = aws.cert_region

  domain_name       = var.page_domain_name
  validation_method = "DNS"

  tags = var.resource_tags

  lifecycle {
    create_before_destroy = true
  }
}

# Get our route53 hosted zone for the domain name
data "aws_route53_zone" "zone" {
  # This resource will be created in the default region
  provider = aws.default

  name         = "${var.page_domain_name}."
  private_zone = false
}

# Cert validation works by requiring us to create a dns server entry for our domain
# to proove that we are really in control of it. The actual name record is a random
# string we get from the cert validation options
resource "aws_route53_record" "cert_validation" {
  # This resource will be created in the default region
  provider = aws.default

  name    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_name
  type    = aws_acm_certificate.cert.domain_validation_options.0.resource_record_type
  zone_id = data.aws_route53_zone.zone.id
  records = [aws_acm_certificate.cert.domain_validation_options.0.resource_record_value]
  ttl     = 60
}

# When the cert request and route53 entry has been created, we can actually create the
# validation "object" and export the cert arn
resource "aws_acm_certificate_validation" "cert" {
  # For cloudfront the certificate has to be created in us east 1
  provider = aws.cert_region

  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}