resource "aws_lb_target_group" "target_group" {
  for_each = { for tg in var.target_groups : "${tg.port}-${tg.health_check.path}" => tg }

  # Derive a name from the target group's properties for idempotency
  name = "${var.project}-${var.environment}-${var.alb_name}-${each.value.port}-tg"
  port        = each.value.port
  protocol    = "HTTPS"
  target_type = "ip"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = each.value.health_check.enabled
    healthy_threshold   = each.value.health_check.healthy_threshold
    path                = each.value.health_check.path
    interval            = each.value.health_check.interval
    matcher             = each.value.health_check.matcher
    port                = each.value.health_check.port
    protocol            = each.value.health_check.protocol
    timeout             = each.value.health_check.timeout
    unhealthy_threshold = each.value.health_check.unhealthy_threshold
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}