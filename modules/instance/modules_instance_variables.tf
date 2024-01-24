variable "instance_family_image" {
  description = "Instance image"
  type        = string
  default     = "lemp"
}

variable "vpc_subnet_id" {
  description = "VPC subnet network id"
  type        = string
}
