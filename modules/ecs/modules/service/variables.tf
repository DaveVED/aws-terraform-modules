variable "service_name" {
  type        = string
  description = "ECS Cluster Service name."
}

variable "cluster_id" {}
variable "task_definition_arn" {}
variable "security_group_ids" {}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets for the Service."
}

variable "desired_task_count" {
  default = 1
}
