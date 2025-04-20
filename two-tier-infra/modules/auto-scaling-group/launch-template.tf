resource "aws_launch_template" "web_lt" {
  name = "web-lt"
  image_id      = var.ami # Replace with your AMI
  instance_type = var.instance_type
  key_name      = var.key_name


  user_data = base64encode(<<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt install -y docker.io docker-compose
              EOF
  )

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [var.web_sg]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "Web-Instance"
      tier = "web"
    }
  }
}
