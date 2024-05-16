data "aws_ami" "ubuntu" {
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20240411"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# data "aws_subnet" "private_subnet" {
#   filter {
#     name   = "tag:Name"
#     values = ["${var.env}-${local.project}-private-subnet"]
#   }
# }

# data "aws_subnet" "public_subnet" {
#   filter {
#     name   = "tag:Name"
#     values = ["${var.env}-${local.project}-public-subnet"]
#   }
# }
