resource "aws_vpc" "myVPC" {
  cidr_block = var.vpc_cidr
  tags = {
    name = "myVPC"
  }
}

resource "aws_internet_gateway" "myIgw" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_subnet" "mySubnets" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.subnets_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true # add public ip with instance automatically
  tags = {
    Name = "mySubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "myRouteTable" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIgw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "myRouteTableAssociation" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.mySubnets.*.id, count.index)
  route_table_id = aws_route_table.myRouteTable.id
}
