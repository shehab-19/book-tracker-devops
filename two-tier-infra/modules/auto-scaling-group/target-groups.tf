resource "aws_lb_target_group" "alb-target-group" {
  name        = "alb-target-group"
  target_type = "instance"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc-id
}


# attach target group to the ALB
resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-group.arn
  }
  
}


# resource "aws_lb_target_group_attachment" "test" {
#   count = length(aws_instance.web)
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = aws_instance.web[count.index].id
#   port             = 5000
# }