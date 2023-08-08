##################
# VPC
##################
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge({ "Name" = "${var.project}-${var.environment}-vpc" }, var.default_tags)
}

##################
# Subnets
##################
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

##################
# Internet Routes
##################
resource "aws_route_table" "internet_table" {
  count = local.num_internet_subnets

  vpc_id = aws_vpc.vpc.id

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  tags = merge({ "Name" = "${var.project}-${var.environment}-internet-rtb${count.index + 1}-${element(var.supported_internet_azs, count.index)}" }, var.default_tags)
}

resource "aws_route" "route" {
  count = local.num_internet_subnets

  route_table_id         = element(aws_route_table.internet_table[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

  depends_on = [aws_route_table.internet_table]
}

resource "aws_route_table_association" "association" {
  count = local.num_internet_subnets

  subnet_id      = element(aws_subnet.internet_subnets[*].id, count.index)
  route_table_id = element(aws_route_table.internet_table[*].id, count.index)

  depends_on = [aws_route_table.internet_table]
}

resource "aws_route_table" "internal_table" {
  vpc_id = aws_vpc.vpc.id

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  tags = merge({ "Name" = "${var.project}-${var.environment}-internal-rtb" }, var.default_tags)
}

##################
# Internal Routes
##################
resource "aws_route_table" "internal_table" {
  vpc_id = aws_vpc.vpc.id

  timeouts {
    create = "10m"
    update = "10m"
    delete = "10m"
  }

  tags = merge({ "Name" = "${var.project}-${var.environment}-internal-rtb" }, var.default_tags)
}

resource "aws_route" "internal_route" {
  route_table_id         = aws_route_table.internal_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

  depends_on = [aws_route_table.internal_table]
}

resource "aws_route_table_association" "internal_association" {
  count = local.num_internal_subnets

  subnet_id      = element(aws_subnet.internal_subnets[*].id, count.index)
  route_table_id = aws_route_table.internal_table.id

  depends_on = [aws_route_table.internal_table]
}