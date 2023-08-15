resource "aws_cloudwatch_log_group" "ecs" {
  for_each = var.task_definitions

  name = "${each.value.family}-task-definition-logs"
}