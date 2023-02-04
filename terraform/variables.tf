variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-west-2"
}

variable "vpc_block" {
  description = "cidr block for the vpc"
  type = object({
    cidr_block = string
    name       = string
  })
}

variable "subnet_blocks" {
  description = "cidr blocks for the subnets"
  type = map(object({
    cidr = string
    az   = string
  }))
}

variable "igw" {
  description = "internet gateway"
  type        = string
}

variable "rtb" {
  description = "cidr block for the route table"
  type = object({
    cidr_block = string
    name       = string
  })
}

variable "sg" {
  description = "Application load balancer and instances security group name"
  type        = list(string)
}

variable "inbound_ports" {
  description = "Inbound ports for the security group."
  type        = list(number)
  default     = [80, 443]

}

variable "ssh_key" {
  description = "SSH key for the ec2 instances"
  type        = string
}

variable "lb_name" {
  description = "name of the load balancer"
  type        = string
}

variable "tg_name" {
  description = "name of the target group"
  type        = string
}

variable "domain_names" {
  description = "domain names for the ec2 instances"
  type        = map(string)
}

variable "token" {
  description = "Name.com API token"
  type        = string
}

variable "username" {
  description = "Name.com username"
  type        = string
}