variable "task_definition_arns" {
  description = "A map of task definition family to its ARN for creating the ECS services."
  type        = map(string)
  default     = {}
}

variable "load_balancer_target_group_arns" {
  description = "A map of target group identifiers to their ARNs for attaching to the ECS services."
  type        = map(string)
  default     = {}
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