###cloud vars
variable "secret_key" {
  type        = string
  description = ""
}

variable "access_key" {
  type        = string
  description = ""
}


variable "default_zone" {
  type        = string
  default     = "eu-central-1"
  description = ""
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = ""
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

#////////////////////////////////////


variable "instance_cores" {
  description = "Number of cores for instances"
  type        = number
  default     = 2
}

variable "instance_memory" {
  description = "Amount of memory for instances (GB)"
  type        = number
  default     = 1
}

variable "core_fraction" {
  description = "Core fraction for instances"
  type        = number
  default     = 5
}

variable "boot_disk_type" {
  description = "Type of boot disk"
  type        = string
  default     = "network-hdd"
}


variable "vpc_network_name" {
  description = "Name of the VPC network"
  type        = string
  default     = "vpc-network"
}

variable "private_subnet_name" {
  description = "Name of the private subnet"
  type        = string
  default     = "private"
}

variable "public_subnet_name" {
  description = "Name of the public subnet"
  type        = string
  default     = "public"
}

variable "nat_ip_address" {
  description = "Static IP address for NAT instance"
  type        = string
  default     = "192.168.10.254"
}

variable "ssh_keys" {
  description = "SSH public keys"
  type        = string
  default     = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23"
}


# Variables
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

# Create a VPC
resource "aws_vpc" "netology_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "netology_vpc"
  }
}