resource "aws_lb" "terra_lb" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [for subnet in aws_subnet.terra_subnets : subnet.id]

}

resource "aws_lb_target_group" "terra_target" {
  name     = var.tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.terra_vpc.id

  health_check {
    port     = 80
    protocol = "HTTP"
    path     = "/"
    matcher  = "200-299"
  }

}

resource "aws_lb_target_group_attachment" "terra_attachment" {
  for_each         = aws_instance.ec2_instance
  target_group_arn = aws_lb_target_group.terra_target.arn
  target_id        = each.value.id
  port             = 80
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.terra_lb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.terra_target.arn
  }
}