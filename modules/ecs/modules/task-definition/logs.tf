resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.project}-${var.environment}-${var.task_definition.family}-logs"
}