# data "aws_instance" "foo" {
#   instance_id = "i-instanceid"

#   source_dest_check=false

#   filter {
#     name   = "image-id"
#     values = ["ami-xxxxxxxx"]
#   }

#   filter {
#     name   = "tag:Name"
#     values = ["instance-name-tag"]
#   }

#   provisioner "remote-exec" {
#     inline = [
#       "sysctl -w net.ipv4.ip_forward=1",
#       "/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE",
#     ]
#   }
# }
