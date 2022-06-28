terraform {
  backend "s3" {
    bucket                  = "demo-bucket"
    key                     = "state-file/terraform.tfstate"
    region                  = "${var.region}"
    shared_credentials_file = "/etc/awscredentials"
	dynamodb_table          = "terraform-state-lock-table"
  }
}

# EC2 Instances
resource "aws_instance" "webserver1" {
  ami                    = "${var.default_ami}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.az-a}"
  vpc_security_group_ids = ["${aws_security_group.webserver-sg.id}"]
  subnet_id              = "${aws_subnet.web-subnet-1.id}"
  tags = {
    Name = "Web Server 1"
  }
}

resource "aws_instance" "webserver2" {
  ami                    = "${var.default_ami}"
  instance_type          = "t2.micro"
  availability_zone      = "${var.az-b}"
  vpc_security_group_ids = ["${aws_security_group.webserver-sg.id}"]
  subnet_id              = "${aws_subnet.web-subnet-2.id}"
  tags = {
    Name = "Web Server 2"
  }
}