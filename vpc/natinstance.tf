data "aws_ami" "linux2" {
  most_recent = true

  filter {
    name   = "name"
    values=["amzn2-ami-hvm*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"] # Canonical
}

resource "aws_instance" "nat_instance" {
  ami           = "${data.aws_ami.linux2.id}"
  instance_type = "t2.micro"

  source_dest_check=false

  vpc_security_group_ids = ["${aws_security_group.nat-sg.id}"]

  subnet_id = aws_subnet.public.id

  user_data = <<-EOT
		#! /bin/bash
        sysctl -w net.ipv4.ip_forward=1
        /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  EOT
}

resource "aws_eip" "lb" {
  instance = "${aws_instance.nat_instance.id}"
  vpc      = true
}

resource "aws_security_group" "nat-sg" {
  name        = "nat-sg"
  description = "Permissions for NAT Instance"
  vpc_id      = aws_vpc.main.id

  ingress {
    security_groups = [var.api_sg_id]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nat-sg"
  }
}
