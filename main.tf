resource "aws_instance" "my-instance" {
  # Creates 3 identical aws ec2 instances
  count = 3

  # All 3 instances will have the same ami and instance_type
  ami           = lookup(var.ec2_ami, var.region)
  instance_type = var.instance_type # 
  tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "ec2-instance-${count.index}"
  }
}

