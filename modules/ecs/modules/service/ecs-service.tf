resource "aws_ecs_service" "ecs_alb" {
  for_each = var.task_definition_arns

  name            = "${each.key}-service"
  cluster         = var.cluster_id
  task_definition = each.value
  launch_type     = "FARGATE"
  desired_count   = var.desired_task_count

  load_balancer {
    target_group_arn = var.load_balancer_target_group_arns[each.key]
    container_name   = var.container_names[each.key] 
    container_port   = var.container_ports[each.key]
  }

  network_configuration {
    subnets          = var.subnet_ids
    assign_public_ip = true
    security_groups  = var.security_group_ids
  }
}