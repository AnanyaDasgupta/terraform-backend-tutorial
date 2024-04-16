resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_conf.cidr_block
  instance_tenancy     = var.vpc_conf.instance_tenancy
  enable_dns_hostnames = var.vpc_conf.enable_dns_hostnames
  enable_dns_support   = var.vpc_conf.enable_dns_support
  tags = {
    Name          = "${var.env}-${local.project}-vpc"
    CreatedByTer  = true
  }
}