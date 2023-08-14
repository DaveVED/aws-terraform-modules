variable "default_tags" {
  type        = map(string)
  description = "Default tags you would like mapped to all resources created by this module."
}

variable "project" {
  type        = string
  description = "Project name, for which resources are being provisonied."
}

variable "environment" {
  type        = string
  description = "AWS environment type to deploy the resources to."
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS Cluster Name."
}
