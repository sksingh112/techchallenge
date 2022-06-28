resource "aws_lb" "external-alb" {
  name               = "External-ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.web-sg.id}"]
  subnets            = ["${aws_subnet.web-subnet-1.id}", "${aws_subnet.web-subnet-2.id}"]
}

resource "aws_lb_target_group" "external-alb-tg" {
  name     = "Ext-ALB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${aws_vpc.demo-vpc.id}"
}

resource "aws_lb_target_group_attachment" "external-alb-tga" {
  target_group_arn = "${aws_lb_target_group.external-alb-tg.arn}"
  target_id        = "${aws_instance.webserver1.id}"
  port             = 80

  depends_on = [
    aws_instance.webserver1
  ]
}

resource "aws_lb_target_group_attachment" "external-alb-tga" {
  target_group_arn = "${aws_lb_target_group.external-lb-tg.arn}"
  target_id        = "${aws_instance.webserver2.id}"
  port             = 80

  depends_on = [
    aws_instance.webserver2,
  ]
}

resource "aws_lb_listener" "external-alb-listener" {
  load_balancer_arn = "${aws_lb.external-alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.external-alb-tg.arn}"
  }
}