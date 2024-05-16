locals {
  project        = "demo"
  aws_account_id = 891377396203
  key_name       = "env:/${var.env}/ssh-keys/${var.env}-${local.project}-key.pem"
}
