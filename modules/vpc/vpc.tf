##########
# VPC
##########
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge({ "Name" = "${var.project}-${var.environment}-vpc" }, var.default_tags)
}

##########
# Subnets
##########
resource "aws_subnet" "internet_subnets" {
  count = local.num_internet_subnets

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.supported_internet_azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, local.subnet_breakup, count.index)

  tags = merge({ "Name" = "${var.project}-${var.environment}-internet-subnet${count.index + 1}-${element(var.supported_internet_azs, count.index)}" }, var.default_tags)
}

resource "aws_subnet" "internal_subnets" {
  count = local.num_internal_subnets

  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.supported_internal_azs[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, local.subnet_breakup, local.num_internet_subnets + count.index)

  tags = merge({ "Name" = "${var.project}-${var.environment}-internal-subnet${count.index + 1}-${element(var.supported_internal_azs, count.index)}" }, var.default_tags)
}