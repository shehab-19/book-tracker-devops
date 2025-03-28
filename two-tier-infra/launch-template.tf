resource "aws_launch_template" "web_lt" {
  name = "web-lt"
  image_id      = var.ami # Replace with your AMI
  instance_type = var.t2-instance_type
  key_name      = aws_key_pair.mykey.key_name


  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt install -y docker.io docker-compose
              EOF
  )

  network_interfaces {
    associate_public_ip_address = false 
    security_groups = [aws_security_group.web_sg.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web-Instance"
    }
  }
}
