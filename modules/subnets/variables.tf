variable "vpc_id" {
  description = "The VPC ID where the subnets will be created."
  type        = string
}

variable "availability_zones" {
  description = "List of two Availability Zones."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_subnet_cidr_az1" {
  description = "CIDR block for the public subnet in AZ1."
  type        = string
}

variable "public_subnet_cidr_az2" {
  description = "CIDR block for the public subnet in AZ2."
  type        = string
}

variable "private_subnet_cidr_az1" {
  description = "CIDR block for the private subnet in AZ1."
  type        = string
}

variable "private_subnet_cidr_az2" {
  description = "CIDR block for the private subnet in AZ2."
  type        = string
}
