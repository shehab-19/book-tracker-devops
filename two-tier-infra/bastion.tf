resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.t2-instance_type
  subnet_id     = aws_subnet.public[0].id
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name = 

user_data = filebase64("${pwd}/bastion.sh")

  tags = {
    Name = "bastion"
  }
}