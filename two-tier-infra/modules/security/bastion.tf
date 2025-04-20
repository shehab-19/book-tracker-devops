resource "aws_iam_role" "bastion_role" {
  count = "${var.make_bastion}" ? 1 : 0
  name               = "bastion_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  
}

resource "aws_iam_policy_attachment" "bastion_role_policy_attachment" {
  count = "${var.make_bastion}" ? 1 : 0
  name       = "bastion_role_policy_attachment"
  roles      =  [aws_iam_role.bastion_role[count.index].name]
  policy_arn = aws_iam_policy.ec2_full_access.arn
  
}

resource "aws_iam_instance_profile" "bastion_instance_profile" {
  count = "${var.make_bastion}" ? 1 : 0
  name = "bastion_instance_profile"
  role = aws_iam_role.bastion_role[count.index].name
}


resource "aws_instance" "bastion" {
  count = "${var.make_bastion}" ? 1 : 0
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.bastion-public-subnet
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = aws_key_pair.mykey.key_name
  associate_public_ip_address = true
  iam_instance_profile = aws_iam_instance_profile.bastion_instance_profile[count.index].name
  user_data = filebase64("scripts/${var.user_data}")

  tags = {
    Name = "bastion"
  }
}