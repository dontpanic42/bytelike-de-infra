output "cert_arn" {
  description = "Arn of the certificate that was created for the supplied domain name"
  value       = aws_acm_certificate_validation.cert.certificate_arn
}