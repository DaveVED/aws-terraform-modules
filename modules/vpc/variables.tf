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

variable "supported_internet_azs" {
  type        = list(string)
  default     = []
  description = "List of supported AZs for the VPC."
}

variable "supported_internal_azs" {
  type        = list(string)
  default     = []
  description = "List of supported AZs for the VPC."
}

variable "default_sg_ingress" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    }
  ]
  description = "List of ingress rules for the default Securty Group."
}

variable "default_sg_egress" {
  type = list(object({
    from_port = number
    to_port   = number
    protocol  = string
  }))
  default = [
    {
      from_port = 0
      to_port   = 0
      protocol  = "-1"
    }
  ]
  description = "List of egress rules for the deafult Security Group."
}
