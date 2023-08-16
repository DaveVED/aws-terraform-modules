resource "aws_alb" "application_load_balancer" {
  name               = "${var.project}-${var.environment}-${var.alb_name}-lb"
  load_balancer_type = "application"
  internal           = var.internal_alb
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
}