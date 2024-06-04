###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

#////////////////////////////////////

variable "zone" {
  description = "Zone in which to create resources"
  type        = string
  default     = "ru-central1-a"
}

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

variable "boot_disk_image_id" {
  description = "Image ID for boot disk"
  type        = string
  default     = "fd8idq8k33m9hlj0huli"
}

variable "boot_disk_type" {
  description = "Type of boot disk"
  type        = string
  default     = "network-hdd"
}

variable "boot_disk_size" {
  description = "Size of boot disk (GB)"
  type        = number
  default     = 20
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

variable "private_cidr_block" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "192.168.20.0/24"
}

variable "public_cidr_block" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "192.168.10.0/24"
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
