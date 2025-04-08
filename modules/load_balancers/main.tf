resource "aws_lb" "public_alb" {
  name               = "${var.project_name}-public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_lb_sg_id]
  subnets            = var.public_subnets
}

resource "aws_lb_target_group" "public_tg" {
  name     = "${var.project_name}-public-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "public_listener" {
  load_balancer_arn = aws_lb.public_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "public_targets" {
  for_each         = var.public_instance_ids
  target_group_arn = aws_lb_target_group.public_tg.arn
  target_id        = each.value
  port             = 80
}

resource "aws_lb" "private_alb" {
  name               = "${var.project_name}-private-alb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.private_lb_sg_id]
  subnets            = var.private_subnets
}

resource "aws_lb_target_group" "private_tg" {
  name     = "${var.project_name}-private-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "private_listener" {
  load_balancer_arn = aws_lb.private_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.private_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "private_targets" {
  for_each         = var.private_instance_ids
  target_group_arn = aws_lb_target_group.private_tg.arn
  target_id        = each.value
  port             = 80
}
