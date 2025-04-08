variable "vpc_id" {
  description = "The ID of the VPC to create the Routing Table."
  type        = string
}

variable "subnet_id" {
  description = "The Subnet ID (public subnet) in which to place the NAT Gateway"
  type        = string
}

variable "private_subnet_az1_id" {
  description = "The ID of the private subnet in AZ1 to associate with the NAT route table"
  type        = string
}

variable "private_subnet_az2_id" {
  description = "The ID of the private subnet in AZ2 to associate with the NAT route table"
  type        = string
}
