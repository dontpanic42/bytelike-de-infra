variable "page_domain_name" {
  description = "Domain name of the webiste (eg. bytelike.de)"
  type        = string
  default     = "bytelike.de"
}

variable "resource_tags" {
  description = "Tags attached to all resources"
  type        = map(string)
  default = {
    "env" = "prod"
    "app" = "bytelike.de"
  }
}