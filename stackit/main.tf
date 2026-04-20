terraform {
  required_version = "~>1.11.5"
  required_providers {
    stackit = {
      source  = "stackitcloud/stackit"
      version = "0.91.0"
    }
    cloudfoundry = {
      source  = "cloudfoundry/cloudfoundry"
      version = "1.14.0"
    }
  }

  backend "s3" {
    bucket = "terraformstates"
    key    = "sampleprojectcloudfoundry.tfstate"
    endpoints = {
      s3 = "https://object.storage.eu01.onstackit.cloud"
    }
    region                      = "eu01"
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_s3_checksum            = true
    skip_requesting_account_id  = true
  }
}

provider "stackit" {
  default_region = var.region
  #use_oidc       = true
}

