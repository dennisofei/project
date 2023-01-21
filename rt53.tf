data "aws_route53_zone" "first-zone" {
  name = "nanayawdebrah.net"
}



resource "aws_route53_record" "app-domain" {
  zone_id = data.aws_route53_zone.first-zone.zone_id
  name = "www"
  type = "A"


  alias {
    name =   aws_lb.front-facing-alb.dns_name     
    zone_id = aws_lb.front-facing-alb.zone_id
    evaluate_target_health = true
  }
    
}
