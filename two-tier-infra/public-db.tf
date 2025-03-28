# resource "aws_db_instance" "default" {
#   allocated_storage    = 10
#   db_name              = var.db-name
#   identifier           = var.db-identifier
#   db_subnet_group_name = aws_db_subnet_group.subnet_group.name
#   engine               = "mysql"
#   engine_version       = "8.0"
#   instance_class       = "db.t3.micro"
#   username             = data.aws_ssm_parameter.db-username.value # can be replced with var.db-username in your db-secrets.tf
#   password             = data.aws_ssm_parameter.db-password.value # can be replced with var.db-password in your db-secrets.tf
#   parameter_group_name = "default.mysql8.0"
#   multi_az             = false
#   storage_type         = "gp2"
#   storage_encrypted    = true 
#   deletion_protection  = false
#   skip_final_snapshot  = true
#   publicly_accessible  = true

#   vpc_security_group_ids = [aws_security_group.db_sg.id]
    
#     tags = {
#         Name = "mydb"
#     }
# }

# resource "aws_db_subnet_group" "subnet_group" {
#   name       = "mydb-subnet-group"
#   subnet_ids =  [aws_subnet.public[tolist(keys(aws_subnet.public))[0]].id , aws_subnet.public[tolist(keys(aws_subnet.public))[1]].id] 
#   tags = {
#     Name = "mydb-subnet-group"
#   } 
# }
