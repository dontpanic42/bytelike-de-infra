variable "page_domain_name" {
  description = "domain name of the webiste (eg. bytelike.com)"
  type        = string
}

variable "resource_tags" {
  description = "Tags attached to all resources"
  type        = map(string)
}