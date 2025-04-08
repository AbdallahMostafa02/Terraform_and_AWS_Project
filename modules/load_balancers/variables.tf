variable "project_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_instance_ids" {
  type = map(string)
}

variable "private_instance_ids" {
  type = map(string)
}

variable "public_lb_sg_id" {
  type = string
}

variable "private_lb_sg_id" {
  type = string
}
