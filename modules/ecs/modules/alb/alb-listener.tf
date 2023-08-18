resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "443"
	ssl_policy		=	"ELBSecurityPolicy-2016-08"
  certificate_arn  = var.cert_arn

  # Dynamically set the default actions for each target group
  dynamic "default_action" {
    for_each = [for tg in var.target_groups : {
      type = "forward"
      target_group_arn = aws_lb_target_group.target_group["${tg.port}-${tg.health_check.path}"].arn
    }]
    content {
      type             = default_action.value.type
      target_group_arn = default_action.value.target_group_arn
    }
  }
}