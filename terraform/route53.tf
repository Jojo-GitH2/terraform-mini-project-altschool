resource "aws_route53_zone" "main" {
  name    = var.domain_names.domain_name
  comment = "jonah-hng.live"
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.domain_names.subdomain_name
  type    = "A"
  #   ttl = "300"
  #   records = ["${aws_elb.elb.dns_name}"]
  alias {
    name                   = aws_elb.terra_lb.dns_name
    zone_id                = aws_elb.terra_lb.zone_id
    evaluate_target_health = false
  }
}