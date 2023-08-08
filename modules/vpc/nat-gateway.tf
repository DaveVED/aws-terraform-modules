resource "aws_eip" "nat" {
  tags = merge({ "Name" = "${var.project}-${var.environment}-nat-eip${count.index + 1}" }, var.default_tags)
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.internet_subnets[0].id

  tags = merge({ "Name" = "${var.project}-${var.environment}-nat-gateway" }, var.default_tags)
}