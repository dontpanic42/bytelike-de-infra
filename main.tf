module "s3" {
  source           = "./modules/s3"
  page_domain_name = var.page_domain_name
  resource_tags    = var.resource_tags
}

module "acm" {
  source           = "./modules/acm"
  page_domain_name = var.page_domain_name
  resource_tags    = var.resource_tags
}