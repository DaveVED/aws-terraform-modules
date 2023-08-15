output "task_definition_arns" {
  description = "ARNs of the ECS Task Definitions"
  value       = { for td in aws_ecs_task_definition.ecs : td.family => td.arn }
}

output "task_definitions" {
  description = "List of the ECS Task Definitions"
  value       = values(aws_ecs_task_definition.ecs)
}
