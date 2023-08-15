resource "aws_ecs_task_definition" "ecs" {
  family = var.task_definition.family
  container_definitions = jsonencode([
    {
      name      = var.task_definition.family
      image     = var.task_defintion.ecr_iamge
      cpu       = var.task_definition.cpu
      memory    = var.task_definition.memory
      essential = var.task_definition.essential
      portMappings = [
        {
          containerPort = var.task_definition.port
          hostPort      = var.task_definition.port
        }
      ],
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs.name
          "awslogs-region"        = data.aws_region.current.name
          "awslogs-stream-prefix" = "streaming"
        }
      }
      healthCheck = {
        retries     = var.task_definition.healthCheck_retries
        interval    = var.task_definition.healthCheck_interval
        timeout     = var.task_definition.healthcheck_timeout
        startPeriod = var.task_definition.healthcheck_startperiod
        command     = ["CMD-SHELL", "echo hello"]
      }
    },
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = var.task_definition.network_mode
  memory                   = var.task_definition.memory
  cpu                      = var.task_definition.cpu
  execution_role_arn       = var.task_definition.execution_role
  task_role_arn            = var.task_definition.task_role
}