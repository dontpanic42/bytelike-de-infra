terraform {
  backend "s3" {
    bucket = "bytelike.de-state"
    key    = "bytelike.de.tfstate"
    region = "eu-central-1"
  }
}