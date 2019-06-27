// https://www.terraform.io/docs/providers/aws/r/lb.html

resource "aws_lb" "service" {
  name = "${var.project_name}-${var.service_name}"
  internal = false
  load_balancer_type = "application"
  security_groups = var.lb_security_group_ids
  subnets = var.lb_subnet_ids


  tags = {
    Name = "${var.project_name}-${var.service_name}"
    Project = var.project_name
    Owner = var.owner_name
  }
}


// https://www.terraform.io/docs/providers/aws/r/lb_target_group.html
resource "aws_lb_target_group" "service" {
  name = "${var.project_name}-${var.service_name}"
  port = var.service_port
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id
}

// https://www.terraform.io/docs/providers/aws/r/lb_listener.html
resource "aws_lb_listener" "service" {
  load_balancer_arn = aws_lb.service.arn
  port = var.lb_listener_port
  protocol = "HTTP"
  //  ssl_policy = "ELBSecurityPolicy-2016-08"
  //  certificate_arn = "${aws_acm_certificate_validation.cert.certificate_arn}"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.service.arn
  }
}




