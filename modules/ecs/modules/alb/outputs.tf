output "load_balancer_target_group_arns" {
  description = "ARNs of the ALB Target Groups"
  value       = { for tg in aws_lb_target_group.target_group : tg.name => tg.arn }
}
