resource "aws_default_security_group" "ingress_default" {
    vpc_id = aws_vpc.vpc.id
  
    ingress {
      description = "Self"
      protocol    = -1
      from_port   = 0
      to_port     = 0
      self        = true
    }
  
    dynamic "ingress" {
      for_each = var.default_sg_ingress
  
      content {
        description = "Default VPC CIDR - Ingress"
        from_port   = ingress.value.from_port
        to_port     = ingress.value.to_port
        protocol    = ingress.value.protocol
        cidr_blocks = [aws_vpc.vpc.cidr_block]
      }
    }
  
    dynamic "egress" {
      for_each = var.default_sg_egress
  
      content {
        description = "Default VPC CIDR - Egress"
        from_port   = egress.value.from_port
        to_port     = egress.value.to_port
        protocol    = egress.value.protocol
        cidr_blocks = [aws_vpc.vpc.cidr_block]
      }
    }
  
    tags = merge({ "Name" = "${var.project}-${var.environment}-${aws_vpc.vpc.id}-default-sg" }, var.default_tags)
  }
  