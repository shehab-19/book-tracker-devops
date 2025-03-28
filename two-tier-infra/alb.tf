resource "aws_lb" "alb" {
  name               = "alb-for-web-app"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  #   access_logs {
  #   bucket  = aws_s3_bucket.access_logs.bucket
  #   prefix  = "alb-logs"
  #   enabled = true
  # }

  # depends_on = [ aws_s3_bucket.access_logs , aws_s3_bucket_policy.alb_access_logs_policy , aws_s3_bucket_public_access_block.access_logs]

    tags = {
        Name = "custom-alb"
    }
}