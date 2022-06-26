#target group create
resource "aws_lb_target_group" "test-tg" {
  name     = "test-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.my-vpc.id

 lifecycle {
    create_before_destroy = true
  }

health_check {
    path = "/index.html"
    port = "80"
    healthy_threshold = 3
    unhealthy_threshold = 2
    timeout = 5
    interval = 30
  
  }
}

#create listener
resource "aws_lb_listener" "alb-lis" {
  load_balancer_arn = aws_lb.my-elb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test-tg.arn
  }
}

#create elb
resource "aws_lb" "my-elb" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"
  enable_cross_zone_load_balancing =  true
  security_groups    = [aws_security_group.api_elb_sg.id]
  subnets            = [ data.aws_subnet.public-subnet-1.id,data.aws_subnet.public-subnet-2.id]

  enable_deletion_protection = false
  
}


#elb security group create
resource "aws_security_group" "api_elb_sg" {
  name        = "test_sg_one"
  description = "Security Group for ALB"
  vpc_id      = data.aws_vpc.my-vpc.id
  tags = {
      "Name"        = "test_sg_one"
      "Environment" = "dev"
    }
}

resource "aws_security_group_rule" "api_tcp_80_mgx_elb" {
  type              = "ingress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.api_elb_sg.id
}
resource "aws_security_group_rule" "api_tcp_443_mgx_elb" {
  type              = "ingress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.api_elb_sg.id
}
resource "aws_security_group_rule" "api_elb_sg_egress" {
  type              = "egress"
  from_port         = "0"
  to_port           = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.api_elb_sg.id
}