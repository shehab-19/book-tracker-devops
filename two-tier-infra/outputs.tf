# output "bastion_public_ip" {
#   value = module.security.bastion_host_public_ip
# }

output "alb_dns_name" {
  value = module.auto-scaling-group.alb_dns_name  
}

output "alb-db_endpoint" {
  value = module.database.db_endpoint
}
