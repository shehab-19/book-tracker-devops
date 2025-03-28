resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = file("~/.ssh/aws-keypair.pub")  
}

# locals {
#     web-instances-subnets = zipmap(var.web-ec2-name, values(aws_subnet.public))
# }

# resource "aws_instance" "web" {
#     for_each = local.web-instances-subnets
#     ami = var.ami
#     instance_type = var.t2-instance_type
#     subnet_id = local.web-instances-subnets[each.key].id
#     security_groups = [aws_security_group.web_sg.id]
#     key_name = aws_key_pair.mykey.key_name

#     tags = {
#         Name = each.key
#     }
# }

# resource "aws_lb_target_group_attachment" "test" {
#   count = length(aws_instance.web)
#   target_group_arn = aws_lb_target_group.alb-target-group.arn
#   target_id        = aws_instance.web[count.index].id
#   port             = 5000
# }
