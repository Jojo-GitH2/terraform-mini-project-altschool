# Creating a Variable for ami of type map


variable "ec2_ami" {
  type = map(any)

  default = {
    us-west-2 = "ami-04bad3c587fe60d89"
  }
}

# Creating a Variable for region

variable "region" {
  default = "us-west-2"
}


# Creating a Variable for instance_type
variable "instance_type" {
  type = string
}