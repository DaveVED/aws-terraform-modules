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

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block."
}