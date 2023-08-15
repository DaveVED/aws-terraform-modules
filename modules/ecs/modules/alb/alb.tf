resource "aws_alb" "application_load_balancer" {
  name = "${var.project}-${var.environment}-${var.alb_name}-${replace(each.key, "/[^a-zA-Z0-9-]/", "-")}"
  load_balancer_type = "application"
  internal           = true
  subnets            = var.subnet_ids
  security_groups    = var.security_group_ids
}