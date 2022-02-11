output "DNS" {
  value = aws_instance.this.public_dns
  description = "AWS EC2的dns地址"
}

output "IP" {
    value = aws_instance.this.public_ip
    description = "AWS EC2的IP"
}