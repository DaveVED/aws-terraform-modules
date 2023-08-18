output "load_balancer_target_group_arns" {
  description = "ARNs of the ALB Target Groups"
  value = { for tg in aws_lb_target_group.target_group : "${tg.port}-${tg.health_check[0].path}" => tg.arn }
}

output "load_balancer_dns_name" {
  description = "Load balancer DNS name."
  value       = aws_alb.application_load_balancer.dns_name


output "load_balancer_zone_id" {
  description = "Load balancer Zone ID."
  value       = aws_alb.application_load_balancer.zone_id
}