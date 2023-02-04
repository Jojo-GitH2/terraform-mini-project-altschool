resource "aws_vpc" "terra_vpc" {
  cidr_block = var.vpc_block.cidr_block
  #   enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_block.name
  }
}

resource "aws_subnet" "terra_subnets" {
  for_each          = var.subnet_blocks
  vpc_id            = aws_vpc.terra_vpc.id
  cidr_block        = each.value["cidr"]
  availability_zone = each.value["az"]
  #   map_public_ip_on_launch = true
  tags = {
    Name = each.key
  }
}

resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.terra_vpc.id
  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "terra_public_table" {
  vpc_id = aws_vpc.terra_vpc.id
  route {
    cidr_block = var.rtb.cidr_block
    gateway_id = aws_internet_gateway.terra_igw.id
  }
  tags = {
    Name = var.rtb.name
  }
}

resource "awas_route_table_association" "terra_route_association" {
  for_each       = aws_subnet.terra_subnets
  subnet_id      = each.value.id
  route_table_id = aws_route_table.terra_public_table.id
}

resource "aws_security_group" "elb_sg" {
  name        = var.sg[0]
  description = "Allow inbound traffic from the internet for load balancer"
  vpc_id      = aws_vpc.terra_vpc.id
  dynamic "ingress" {
    for_each = var.inbound_ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = var.sg[1]
  description = "Allow inbound traffic from the internet for ec2 instances"
  vpc_id      = aws_vpc.terra_vpc.id
  dynamic "ingress" {
    for_each = var.inbound_ports

    content {
      from_port       = ingress.value
      to_port         = ingress.value
      protocol        = "tcp"
      security_groups = [aws_security_group.elb_sg.id]
    }
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}