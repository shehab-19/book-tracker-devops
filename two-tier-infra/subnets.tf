resource "aws_subnet" "public" {
    for_each = var.public-subnet-cidr_block
    vpc_id = aws_vpc.main.id
    cidr_block = each.value
    availability_zone = local.pub-subnet-az-map[each.key]
    map_public_ip_on_launch = true
    tags = {
        Name = "public-${each.key}"
    }
}

locals {
    pub-subnet-az-map = zipmap(keys(var.public-subnet-cidr_block), var.az)
    priv-subnet-az-map = zipmap(keys(var.private-subnet-cidr_block), var.az)
}

resource "aws_subnet" "private" {
    for_each = var.private-subnet-cidr_block
    vpc_id = aws_vpc.main.id
    cidr_block = each.value
    availability_zone = local.priv-subnet-az-map[each.key]
    map_public_ip_on_launch = false
    tags = {
        Name = "private-${each.key}"
    }
}

