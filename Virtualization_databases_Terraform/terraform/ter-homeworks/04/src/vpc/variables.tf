variable "network_name" {
  type        = string
  description = "Name of the VPC network."
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet."
}

variable "zone" {
  type        = string
  description = "Availability zone for the subnet."
}

variable "cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the subnet."
}
