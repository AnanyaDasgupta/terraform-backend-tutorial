env = "dev"
vpc_conf = {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

public_subnet = {
  public-subnet-1 = {
    cidr_block = "10.0.101.0/24"
    availability_zone = "ap-south-1a"
  }
  public-subnet-2 = {
    cidr_block = "10.0.102.0/24"
    availability_zone = "ap-south-1b"
  }
}

# public_cidr_block = "10.0.101.0/24"
az = "ap-south-1a"

private_cidr_block = "10.0.1.0/24" 

lb_ingress_rules = {
  1 = {
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 80
    to_port         = 80
    security_groups = null
  }
  2 = {
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 443
    to_port         = 443
    security_groups = null
  }

}

lb_egress_rules = {
  1 = {
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    to_port         = 0
    security_groups = null
  }
}

server_ingress_rules = {
  1 = {
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 80
    to_port         = 80
    security_groups = null
  }
  2 = {
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 443
    to_port         = 443
    security_groups = null
  }
  3 = {
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 22
    to_port         = 22
    security_groups = null
  }
}

server_egress_rules = {
  1 = {
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    from_port       = 0
    to_port         = 0
    security_groups = null
  }
}