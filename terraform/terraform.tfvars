vpc_block = { cidr_block = "172.17.0.0/16", name = "project_vpc" }
subnet_blocks = {
  subnet_01 = {
    cidr = "172.17.1.0/24"
    az   = "us-west-2a"
  }
  subnet_02 = {
    cidr = "172.17.2.0/24"
    az   = "us-west-2b"
  }
  subnet_03 = {
    cidr = "172.17.3.0/24"
    az   = "us-west-2c"
  }
}
igw = "project_igw"
rtb = { cidr_block = "0.0.0.0/0", name = "project_rtb" }
sg  = ["project_elb_sg", "project_instances_sg"]

ssh_key = "project_key"

lb_name = "project-elb"
tg_name = "project-tg"

domain_names = { domain_name = "jonah-hng.live", subdomain_name = "terraform-test.jonah-hng.live" }
