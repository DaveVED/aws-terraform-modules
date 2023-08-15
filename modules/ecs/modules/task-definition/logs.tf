resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.task_definition.family}-task-definition-logs"
}