resource "aws_ecs_task_definition" "ecs" {
  for_each = var.task_definitions

  family                   = each.value.family
  requires_compatibilities = ["FARGATE"]
  network_mode             = each.value.network_mode
  memory                   = each.value.memory
  cpu                      = each.value.cpu
  execution_role_arn       = each.value.execution_role_arn
  task_role_arn            = each.value.task_role_arn

  container_definitions = jsonencode([for cd in each.value.container_definitions : {
    name      = cd.name
    image     = cd.image
    cpu       = cd.cpu
    memory    = cd.memory
    essential = cd.essential
    portMappings = [{
      containerPort = cd.containerPort
      hostPort      = cd.hostPort
    }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.ecs[each.key].name
        "awslogs-region"        = data.aws_region.current.name
        "awslogs-stream-prefix" = "streaming"
      }
    }
    healthCheck = {
      retries     = cd.healthCheck_retries
      interval    = cd.healthCheck_interval
      timeout     = cd.healthcheck_timeout
      startPeriod = cd.healthcheck_startperiod
      command     = cd.command
    }
  }])
}