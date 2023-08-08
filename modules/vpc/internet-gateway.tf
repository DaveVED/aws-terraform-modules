resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({ "Name" = "${var.project}-${var.environment}-${aws_vpc.vpc.id}-igw" }, var.default_tags)
}