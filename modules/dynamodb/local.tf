locals {
  read_capacity  = billing_mode == "PROVISIONED" && var.read_capacity == null ? 5 : var.read_capacity
  write_capacity = billing_mode == "PROVISIONED" && var.write_capacity == null ? 5 : var.read_capacity
}