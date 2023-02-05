# resource "namedotcom_domain_nameservers" "domain_name" {
#   domain_name = var.domain_names.domain_name
#   nameservers = [
#     aws_route53_zone.main.name_servers[0],
#     aws_route53_zone.main.name_servers[1],
#     aws_route53_zone.main.name_servers[2],
#     aws_route53_zone.main.name_servers[3]
#   ]
# }

# This file is meant to set nameservers for my domain name at name.com but I had permission issues with it.
# So I input the nameservers manually at name.com.