provider "aws" {
  region     = var.region
  profile    = var.profile
}

module "userpool" {
  source = "./userpool"
  profile    = var.profile
}

module "vpc" {
  source = "./vpc"
}
