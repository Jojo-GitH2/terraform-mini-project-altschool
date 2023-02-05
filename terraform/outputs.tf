output "elb_target_group_arn" {
  value = aws_lb_target_group.terra_target.arn
}

output "elb_load_balancer_dns_name" {
  value = aws_lb.terra_lb.dns_name
}

output "elb_zone_id" {
  value = aws_lb.terra_lb.zone_id
}
