resource "aws_launch_template" "launch_template" {
  name                 = "${var.env}-${local.project}-launch-template"
  image_id             = data.aws_ami.ubuntu.id
  instance_type        = "t2.micro"
  security_group_names = [aws_security_group.server_sg.name]
  user_data            = filebase64("user_data.sh")
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

