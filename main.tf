provider "aws" {
  region     = var.region
  profile    = var.profile
}

module "userpool" {
  source = "./userpool"
  profile       = var.profile
  client_id     = var.userpool_client_id
  client_secret = var.userpool_client_secret
}

module "vpc" {
  source = "./vpc"
  
  region = var.region
  endpoint_sg_id = aws_security_group.api-sg.id
  api_sg_id = aws_security_group.api-sg.id
}
