variable "vpc_id" {
  description = "The VPC ID where the route table will be created."
  type        = string
}

variable "internet_gateway_id" {
  description = "The ID of the Internet Gateway to be used in the route table."
  type        = string
}

variable "public_subnet_az1_id" {
  description = "The ID of the public subnet in AZ1."
  type        = string
}

variable "public_subnet_az2_id" {
  description = "The ID of the public subnet in AZ2."
  type        = string
}
