resource "aws_vpc" "main" {
  cidr_block = "10.20.0.0/16"

  tags = {
    Name = "crypto-vpc"
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.main.id 
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = var.azs

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.main.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = var.azs

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Crypto App IG"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route = {
    cidr_blocks = ["0.0.0.0/0"]
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "External Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_asso" {
  count = length(var.public_subnet_cidrs)
  subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}

resource "aws_security_group" "sg" {
  name_prefix = "crypto_sg"
  vpc_id = aws_vpc.main.id

  ingress = {
    from_port = 5000
    to_port = 5000
    protocol = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

resource "aws_security_group" "vpcendpointsg" {
  name = "crypto-vpc-endpoint-sg"
  vpc_id = aws_vpc.main.id
  depends_on = [ aws_vpc.main ]
  ingress = {
    from_port = 443
    to_port = 443
    protocol = "tcp"

    cidr_blocks = ["10.20.0.0/16"]
  }
}

resource "aws_vpc_endpoint" "eks" {
  vpc_id = aws_vpc.main.id 
  service_name = "com.amazonaws.us-east-1.eks"
  subnet_ids = [ aws_subnet.private_subnets, aws_subnet.public_subnets ]
  vpc_endpoint_type = "interface"
  security_group_ids = [aws_security_group.vpcendpointsg.id]
  depends_on = [ aws_subnet.private_subnets, aws_subnet.public_subnets, aws_route_table_association.public_subnet_asso ]
  
}


