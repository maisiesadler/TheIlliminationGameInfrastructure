resource "aws_security_group" "api-sg" {
  name        = "api-sg"
  description = "Permissions for TIG Api"
  vpc_id      = "${module.vpc.id}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "api-sg"
  }
}
