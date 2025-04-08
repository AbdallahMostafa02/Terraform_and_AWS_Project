variable "ami_id" {
  description = "The AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "public_subnet_az1_id" {
  description = "The ID of the public subnet in AZ1"
  type        = string
}

variable "public_subnet_az2_id" {
  description = "The ID of the public subnet in AZ2"
  type        = string
}

variable "private_subnet_az1_id" {
  description = "The ID of the private subnet in AZ1"
  type        = string
}

variable "private_subnet_az2_id" {
  description = "The ID of the private subnet in AZ2"
  type        = string
}

variable "key_name" {
  description = "The SSH key name"
  type        = string
}

variable "instances_sg_id" {
  description = "Security Group ID for EC2 instances"
  type        = string
}

variable "private_key_path" {
  description = "Path to the private SSH key"
  type        = string
}

variable "private_lb_dns" {
  description = "DNS name of the private load balancer"
  type        = string
}
