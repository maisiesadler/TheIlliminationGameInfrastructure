resource "aws_cognito_user_pool" "players" {
  name                     = "players"
  auto_verified_attributes = ["email"]
}

provider "aws" {
  alias = "virginia"
  region = "us-east-1"
  profile    = var.profile
}

data "aws_acm_certificate" "login_tig" {
  domain      = "login.theilliminationgame.co.uk"
  types       = ["AMAZON_ISSUED"]
  provider = "aws.virginia"
  most_recent = true
}

resource "aws_cognito_user_pool_domain" "main" {
  domain       = "www.login.theilliminationgame.co.uk"
  user_pool_id = "${aws_cognito_user_pool.players.id}"
  certificate_arn = "${data.aws_acm_certificate.login_tig.arn}"
}

resource "aws_cognito_user_pool_client" "client" {
  name = "client"

  user_pool_id = "${aws_cognito_user_pool.players.id}"

  callback_urls = ["https://www.theilliminationgame.co.uk/"]

  logout_urls = ["https://www.theilliminationgame.co.uk/"]

  allowed_oauth_flows_user_pool_client=true

  allowed_oauth_flows = ["code", "implicit"]

  allowed_oauth_scopes = ["phone", "email", "openid", "profile", "aws.cognito.signin.user.admin"]

  supported_identity_providers = [ "COGNITO", "Google" ]
}

resource "aws_cognito_identity_provider" "players_google_provider" {
  user_pool_id  = "${aws_cognito_user_pool.players.id}"
  provider_name = "Google"
  provider_type = "Google"

  provider_details = {
    authorize_scopes = "email"
    client_id        = var.client_id
    client_secret    = var.client_secret
  }

  attribute_mapping = {
    email    = "email"
    username = "sub"
  }
}