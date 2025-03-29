resource "aws_security_group" "bastion_sg" {
  name        = "bastion_sg"
    description = "Security group for bastion host"
    vpc_id      = aws_vpc.main.id
  
    # ssh access 
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # change this to your IP
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "bastion-host-security-group"
    }

   
}



resource "aws_security_group" "web_sg" {
    name        = "web-sg"
    description = "Security group for web app"
    vpc_id      = aws_vpc.main.id

  
    # web access from anywhere
    ingress {
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        security_groups = [aws_security_group.lb_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-security-group"
    }

    depends_on = [ aws_security_group.lb_sg ]
}

resource "aws_security_group" "lb_sg" {
    name        = "lb-sg"
    description = "Security group for lb app"
    vpc_id      = aws_vpc.main.id

    # HTTP access from anywhere
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }


    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "web-security-group"
    }
}

resource "aws_security_group" "db_sg" {
    name        = "db-sg"
    description = "Security group for database"
    vpc_id      = aws_vpc.main.id

    ingress {
        from_port       = 3306
        to_port         = 3306
        protocol        = "tcp"
        security_groups  = [aws_security_group.web_sg.id]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "db-security-group"
    }

}