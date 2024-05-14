resource "aws_security_group" "lb_sg" {
  name                   = "${var.env}-${local.project}-lb-sg"
  vpc_id                 = aws_vpc.vpc.id
  description            = "${var.env}-${local.project} load balancer security group"
  revoke_rules_on_delete = true
  tags = {
    Name = "${var.env}-${local.project}-lb-sg"
    environment = "${var.env}"
  }
  dynamic "ingress" {
    for_each = var.lb_ingress_rules
    content {
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      security_groups = ingress.value["security_groups"]
    }
  }
  dynamic "egress" {
    for_each = var.lb_egress_rules
    content {
      protocol        = egress.value["protocol"]
      cidr_blocks     = egress.value["cidr_blocks"]
      from_port       = egress.value["from_port"]
      to_port         = egress.value["to_port"]
      security_groups = egress.value["security_groups"]
    }
  }
}

resource "aws_security_group" "server_sg" {
  name                   = "${var.env}-${local.project}-server-sg"
  vpc_id                 = aws_vpc.vpc.id
  # vpc_id                 = "vpc-0a9cbe687a988b736"
  description            = "${var.env}-${local.project} server security group"
  revoke_rules_on_delete = true
  tags = {
    Name = "${var.env}-${local.project}-server-sg"
    environment = "${var.env}"
  }
  dynamic "ingress" {
    for_each = var.server_ingress_rules
    content {
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      security_groups = ingress.value["security_groups"]

    }
  }
  dynamic "egress" {
    for_each = var.server_egress_rules
    content {
      protocol        = egress.value["protocol"]
      cidr_blocks     = egress.value["cidr_blocks"]
      from_port       = egress.value["from_port"]
      to_port         = egress.value["to_port"]
      security_groups = egress.value["security_groups"]
    }
  }
}