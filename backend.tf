terraform {
  backend "s3" {
    bucket = "bytelike.de-state"
    key    = "bytelike.de.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = "~> 2.49"
  }
}