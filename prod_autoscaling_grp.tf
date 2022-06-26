 #launch template creation
resource "aws_launch_template" "my-temp" {
  name = "my-template"
  image_id  = var.ami
  instance_type = var.ins_type
  key_name = var.ins-key
  network_interfaces {
  security_groups = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  # subnet_id                   = data.aws_subnet.public-subnet-1.id
  # delete_on_termination       = false

}

  user_data = filebase64("userdata.sh")

  tag_specifications {
    resource_type = "instance"
    tags = {
      
      "Name" = "test-ec2-instance"

    }

  }

}


#auto scaling group creation
resource "aws_autoscaling_group" "my-asg" {
  name = "my-test-autoscaling-grp"
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  health_check_grace_period = "300"
  health_check_type = "ELB"
  target_group_arns = [aws_lb_target_group.test-tg.arn]
  
  vpc_zone_identifier = [data.aws_subnet.public-subnet-1.id,data.aws_subnet.public-subnet-2.id]
  # suspended_processes = var.suspended_processes
  launch_template {
    id      = aws_launch_template.my-temp.id
    version = "$Latest"
    
  }
}
#auto scaling attachment 
# resource "aws_autoscaling_attachment" "asg_attach" {
#   autoscaling_group_name = aws_autoscaling_group.my-asg.id
#   lb_target_group_arn    = aws_lb_target_group.test-tg.arn
# }