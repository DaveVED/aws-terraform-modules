resource "aws_cloudwatch_log_group" "ecs" {
  name = "${var.project}-${var.environment}-${var.ecs_cluster_name}-logs"
}