resource "aws_ssm_parameter" "secret" {
  name        = "mongodb"
  description = "The parameter description"
  type        = "SecureString"
  value       = var.mongodbconnection
}
