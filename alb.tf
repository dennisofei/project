resource "aws_lb" "front-facing-alb" {
  name               = "front-facing-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Load-Sec-Grp.id]
  subnets            = [aws_subnet.public-sub-1.id,aws_subnet.public-sub-2.id ]

  enable_deletion_protection = false

  ip_address_type = "ipv4"

  /* depends_on = [
    aws_autoscaling_group.web-asg
  ] */


  /* access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  } */

  tags = {
    Environment = "production"
  }
}



# create alb target group

resource "aws_lb_target_group" "alb-target-grp" {


  name     = "alb-target-grp"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.finalpro.id
}



#HTTPS Listener

/* resource "aws_lb_listener" "https-listener" {
  load_balancer_arn = aws_lb.front-facing-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-target-grp.arn
  }
} */


#http listener
resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front-facing-alb.arn
  port              = "80"
  protocol          = "HTTP"
 
  default_action {
    
    target_group_arn = aws_lb_target_group.alb-target-grp.arn
    type             = "forward"
  }
}
