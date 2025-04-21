resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.db-name
  identifier           = var.db-identifier
  db_subnet_group_name = aws_db_subnet_group.subnet_group.name
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = var.db-username # can be replced with var.db-username in your db-secrets.tf
  password             = var.db-password # can be replced with var.db-password in your db-secrets.tf
  parameter_group_name = "default.mysql8.0"
  multi_az             = false
  storage_type         = "gp2"
  storage_encrypted    = true 
  deletion_protection  = false
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [var.db_sg]
    
    tags = {
        Name = "mydb"
    }
}

resource "aws_db_subnet_group" "subnet_group" {
  name       = "mydb-subnet-group"
  subnet_ids =  [var.db-subnets[0], var.db-subnets[1]]
  tags = {
    Name = "mydb-subnet-group"
  } 
}
