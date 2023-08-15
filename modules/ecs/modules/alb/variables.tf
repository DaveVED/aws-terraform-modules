variable "security_group_ids" {}

variable "project" {
  type        = string
  description = "Project name, for which resources are being provisonied."
}

variable "environment" {
  type        = string
  description = "GSIC AWS environment type to deploy the resources to."

  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = <<-EOT
    GSIC AWS environment type to deploy the resources to.
    Supported Values:
      - dev
      - prod
    EOT
  }
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags you would like mapped to all resources created by this module."
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnets for the Service."
}

variable "vpc_id" {}
variable "alb_name" {}
variable "target_group_port" {
  default = 80
}
variable "health_check" {}
variable "alb_paths" {
  default = "/"
}