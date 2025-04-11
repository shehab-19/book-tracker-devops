resource "aws_autoscaling_group" "web-app-asg" {
  name                      = "web-app-asg"
  max_size                  = 3
  min_size                  = 2
  desired_capacity          = 2
  health_check_type         = "ELB"
  
launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
}
  vpc_zone_identifier       = values(aws_subnet.public)[*].id 
}


# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.web-app-asg.name
  lb_target_group_arn = aws_lb_target_group.alb-target-group.arn
}