module "oai" {
  source = "./modules/oai"
}

module "s3" {
  source           = "./modules/s3"
  page_domain_name = var.page_domain_name
  resource_tags    = var.resource_tags
  oai_iam_arn      = module.oai.iam_arn
}

module "acm" {
  source           = "./modules/acm"
  page_domain_name = var.page_domain_name
  resource_tags    = var.resource_tags

  providers = {
    aws.default     = aws.default
    aws.cert_region = aws.us_east_1
  }
}

module "cloudfront" {
  source             = "./modules/cloudfront"
  page_domain_name   = var.page_domain_name
  bucket_domain_name = module.s3.bucket_domain_name
  acm_cert_arn       = module.acm.cert_arn
  cf_oai_path        = module.oai.cf_oai_path
  resource_tags      = var.resource_tags
}