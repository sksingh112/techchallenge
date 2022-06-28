# Web Public Subnet
resource "aws_subnet" "web-subnet-1" {
  vpc_id                  = "${aws_vpc.demo-vpc.id}"
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "${var.az-a}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Web-1a"
  }
}

resource "aws_subnet" "web-subnet-2" {
  vpc_id                  = "${aws_vpc.demo-vpc.id}"
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "${var.az-b}"
  map_public_ip_on_launch = true
  tags = {
    Name = "Web-2b"
  }
}

# Application Public Subnet
resource "aws_subnet" "application-subnet-1" {
  vpc_id                  = "${aws_vpc.demo-vpc.id}"
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "${var.az-a}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Application-1a"
  }
}

resource "aws_subnet" "application-subnet-2" {
  vpc_id                  = "${aws_vpc.demo-vpc.id}"
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "${var.az-b}"
  map_public_ip_on_launch = false
  tags = {
    Name = "Application-2b"
  }
}

# Database Private Subnet
resource "aws_subnet" "database-subnet-1" {
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "10.0.5.0/24"
  availability_zone = "${var.az-a}"
  tags = {
    Name = "Database-1a"
  }
}

resource "aws_subnet" "database-subnet-2" {
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "10.0.6.0/24"
  availability_zone = "${var.az-b}"
  tags = {
    Name = "Database-2b"
  }
}

resource "aws_subnet" "database-subnet" {
  vpc_id            = "${aws_vpc.demo-vpc.id}"
  cidr_block        = "10.0.7.0/24"
  availability_zone = "${var.az-a}"
  tags = {
    Name = "Database"
  }
}