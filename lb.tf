resource "aws_lb" "lb" {
  name               = "${var.env}-${local.project}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public_subnet : subnet.id]

  enable_deletion_protection = true

  tags = {
    Name         = "${var.env}-${local.project}-lb"
    CreatedByTer = true
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.env}-${local.project}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.vpc.id
  health_check {
    enabled             = true
    interval            = 60
    path                = "/"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 30
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}