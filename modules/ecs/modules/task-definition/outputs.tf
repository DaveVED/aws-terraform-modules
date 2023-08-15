output "task_definition_arns" {
  description = "ARNs of the ECS Task Definitions"
  value       = { for td in aws_ecs_task_definition.ecs : td.family => td.arn }
}

output "task_definitions" {
  description = "List of the ECS Task Definitions"
  value       = values(aws_ecs_task_definition.ecs)
}

output "task_definitions_info" {
  description = "A list of task definitions with their ARN, family, and port."
  value = [
    for td in aws_ecs_task_definition.ecs : {
      arn    = td.arn
      family = td.family
      port   = try(td.container_definitions[0].portMappings[0].containerPort, null)  # Assumes only one container definition per task
    }
  ]
}