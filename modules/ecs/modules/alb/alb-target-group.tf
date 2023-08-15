resource "random_string" "random_suffix" {
  length  = 3
  special = false
  upper   = false
}

resource "aws_lb_target_group" "target_group" {
  name        = "${var.project}-${var.environment}-${var.alb_name}-${substr(uuid(), 0, 3)}"
  port        = var.target_group_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = var.health_check.enabled
    healthy_threshold   = var.health_check.healthy_threshold
    path                = var.health_check.path
    interval            = var.health_check.interval
    matcher             = var.health_check.matcher
    port                = var.health_check.port
    protocol            = var.health_check.protocol
    timeout             = var.health_check.timeout
    unhealthy_threshold = var.health_check.unhealthy_threshold
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}