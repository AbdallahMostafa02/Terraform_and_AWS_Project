variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The SSH key name"
  type        = string
  default     = "abdallah"
}

variable "private_key_path" {
  description = "Path to the private SSH key"
  type        = string
  default     = "/home/abdallah/abdallah.pem"
}
