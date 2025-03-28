output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "db_endpoint" {
  value = aws_db_instance.default.address
}