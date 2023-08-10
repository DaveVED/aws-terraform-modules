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

variable "table_name" {
  type        = string
  description = "Dynamodb Table Name."
}

variable "billing_mode" {
  type        = string
  default     = "PROVISIONED"
  description = "Controls how you are charged for read and write throughput."
  validation {
    condition     = contains(["PROVISIONED", "PAY_PER_REQUEST"], var.billing_mode)
    error_message = <<-EOT
                    The billing_mode must be a billing_mode supported by DynamoDb.
                    Valid billing modes:
                        - PROVISIONED
                        - PAY_PER_REQUEST
                    EOT
  }
}

variable "read_capacity" {
  type        = number
  description = "Number of read units for DynamoDb table."
  default     = null
}

variable "write_capacity" {
  type        = number
  description = "Number of write units for this table.."
  default     = null
}

variable "hash_key" {
  type        = string
  description = "Name of the hash key in the index"
}

variable "range_key" {
  type        = string
  default     = null
  description = "Attribute to use as the range (sort) key."
}

variable "attributes" {
  description = "List of attributes for the DynamoDB table."
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "global_secondary_indexes" {
  description = "List of global secondary indexes for the DynamoDB table."
  type = list(object({
    name               = string
    hash_key           = string
    projection_type    = string
    range_key          = optional(string)
    read_capacity      = optional(number)
    write_capacity     = optional(number)
    non_key_attributes = optional(list(string))
  }))
  default = []
}

variable "point_in_time_recovery_enabled" {
  type        = bool
  default     = false
  description = "To enable dynamodb point in time recovery."
}