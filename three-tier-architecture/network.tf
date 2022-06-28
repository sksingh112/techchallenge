# Main VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Demo VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  tags = {
    Name = "Demo IGW"
  }
}

# Web layber route table
resource "aws_route_table" "web-rt" {
  vpc_id = "${aws_vpc.demo-vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags = {
    Name = " Demo WebRT"
  }
}

# Web Subnet association with Web route table
resource "aws_route_table_association" "rta-a" {
  subnet_id      = "${aws_subnet.web-subnet-1.id}"
  route_table_id = "${aws_route_table.web-rt.id}"
}

resource "aws_route_table_association" "rta-b" {
  subnet_id      = "${aws_subnet.web-subnet-2.id}"
  route_table_id = "${aws_route_table.web-rt.id}"
}