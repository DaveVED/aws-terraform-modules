locals {
  num_internet_subnets = length(var.supported_internet_azs)
  num_internal_subnets = length(var.supported_internal_azs)
  total_subnets        = local.num_internet_subnets + local.num_internal_subnets
  subnet_breakup       = ceil(log(local.total_subnets, 2))
}