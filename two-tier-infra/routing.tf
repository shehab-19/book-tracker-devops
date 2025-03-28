resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    
    Name = var.public-rtb-name
  }

 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = { 
    Name = var.private-rtb-name
  } 
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private                            # important note here
  subnet_id = each.value.id
  route_table_id = aws_route_table.private.id
  
}



resource "aws_route_table_association" "public" {
    for_each = aws_subnet.public                            # important note here
    subnet_id = each.value.id
    route_table_id = aws_route_table.public.id
}
