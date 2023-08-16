variable "project" {
  description = "The name of the project."
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}

variable "alb_name" {
  description = "Name for the Application Load Balancer."
  type        = string
}

variable "internal_alb" {
  description = "Internal or public facing ALB"
  type        = bool
  default     = true
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Application Load Balancer."
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs for the Application Load Balancer."
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID where resources will be deployed."
  type        = string
}

variable "target_groups" {
  description = "List of target group configurations."
  type = list(object({
    port                : number
    health_check        : object({
      enabled             : bool
      healthy_threshold   : number
      path                : string
      interval            : number
      matcher             : string
      port                : number
      protocol            : string
      timeout             : number
      unhealthy_threshold : number
    })
  }))
  default = []
}
