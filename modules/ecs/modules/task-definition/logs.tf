resource "aws_cloudwatch_log_group" "ecs" {
  for_each = var.task_definitions

  name = "${each.value.task_definition.family}-task-definition-logs"
}