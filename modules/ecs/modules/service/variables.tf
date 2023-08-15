variable "task_definition_arns" {
  description = "A map of task definition family to its ARN for creating the ECS services."
  type        = map(string)
  default     = {}
}

variable "load_balancer_target_group_arn" {
  description = "The ARN of the target group for the ALB."
  type        = string
}

variable "cluster_id" {
  description = "The ID of the ECS cluster."
  type        = string
}

variable "desired_task_count" {
  description = "The number of desired tasks for the ECS service."
  type        = number
  default     = 1
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the network configuration of the ECS service."
  type        = list(string)
}

variable "security_group_ids" {
  description = "A list of security group IDs for the network configuration of the ECS service."
  type        = list(string)
}

variable "container_name" {
  description = "A map of task definition family to its container name for the load balancer configuration in the ECS services."
  type        = string
}

variable "container_port" {
  description = "A map of task definition family to its container port for the load balancer configuration in the ECS services."
  type        = number
}
