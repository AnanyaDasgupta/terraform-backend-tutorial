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
resource "aws_subnet" "public_subnet" {
  for_each                = var.public_subnet
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name         = "${var.env}-${local.project}-public-subnet"
    CreatedByTer = true
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidr_block
  availability_zone = var.az
  tags = {
    Name          = "${var.env}-${local.project}-private-subnet"
    CreatedByTer  = true
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name         = "${var.env}-${local.project}-igw"
    CreatedByTer = true
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
  depends_on = [ aws_internet_gateway.gw ]

  tags = {
    Name         = "${var.env}-${local.project}-eip"
    CreatedByTer = true
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = [for subnet in aws_subnet.public_subnet : subnet.id][0]

  tags = {
    Name         = "${var.env}-${local.project}-nat"
    CreatedByTer = true
  }

  depends_on = [aws_internet_gateway.gw]
}


