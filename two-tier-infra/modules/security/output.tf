output "web-security_group_id" {
  value       = aws_security_group.web_sg.id
}

output "lb-security_group_id" {
  value       = aws_security_group.lb_sg.id
}

output "db-security_group_id" {
  value       = aws_security_group.my-sqldb-sg.id
}

output "aws_key_pair_name" {
  value       = aws_key_pair.mykey.key_name
}

output "bastion_host_public_ip" {
  value       = aws_instance.bastion[0].public_ip
}

output "ssm_db_username" {
  value       = data.aws_ssm_parameter.db-username.value  
}

output "ssm_db_password" {
  value       = data.aws_ssm_parameter.db-password.value
}