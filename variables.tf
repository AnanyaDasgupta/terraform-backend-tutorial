variable "env" {
  type = string
}

variable "vpc_conf" {
  type = map(any)
}

variable "public_subnet" {
  type        = map(any)
  description = "Public Subnets to be created"
}

# variable "private_subnet" {
#   type        = map(any)
#   description = "Private Subnets to be created"
# }

variable "az" {
  type = any
}

# variable "public_cidr_block" {
#   type = string
# }

variable "private_cidr_block" {
  type = string
}

variable "lb_ingress_rules" {
  type = any
}

variable "lb_egress_rules" {
  type = any 
}

variable "server_ingress_rules" {
  type = any 
}

variable "server_egress_rules" {
  type = any 
}