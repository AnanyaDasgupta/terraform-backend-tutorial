resource "tls_private_key" "tls" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.env}-${local.project}-key"
  public_key = tls_private_key.tls.public_key_openssh
}

resource "aws_s3_bucket" "tls_key_bucket" {
  bucket = "${var.env}-${local.project}-key"
  # acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "tls" {
  bucket = aws_s3_bucket.tls_key_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.tls]

  bucket = aws_s3_bucket.tls_key_bucket.id
  acl    = "private"
}
resource "aws_s3_object" "tls_key_bucket_object" {
  key     = local.key_name
  bucket  = aws_s3_bucket.tls_key_bucket.id
  content = tls_private_key.tls.private_key_pem
}

resource "aws_launch_template" "launch_template" {
  name          = "${var.env}-${local.project}-launch-template"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  # security_group_names = [aws_security_group.server_sg.name] 
  vpc_security_group_ids = [aws_security_group.server_sg.id] # fetch details of security groups in non-default vpc using security id and not name, and vice-versa
  user_data              = filebase64("user_data.sh")
  key_name               = aws_key_pair.key_pair.key_name
  tags = {
    Name         = "${var.env}-${local.project}-launch-template"
    CreatedByTer = true
  }
}

resource "aws_autoscaling_group" "asg" {
  #   availability_zones = [var.availability_zone]
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1
  vpc_zone_identifier = [aws_subnet.private_subnet.id]
  name                = "${var.env}-${local.project}-asg"

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.tg.arn]


  tag {
    key                 = "Name"
    value               = "${var.env}-${local.project}-asg"
    propagate_at_launch = true
  }

  tag {
    key                 = "CreatedByTer"
    value               = true
    propagate_at_launch = true
  }


}

