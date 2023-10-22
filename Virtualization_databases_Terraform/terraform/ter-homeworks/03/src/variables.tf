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

variable "vm_configurations" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  
  default = [
    {
      vm_name = "main"
      cpu     = 2
      ram     = 1
      disk    = 8
    },
    {
      vm_name = "replica"
      cpu     = 2
      ram     = 2
      disk    = 10
    }
  ]
}

variable "vm_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
    boot_disk_size = number
  }))
  default = {
    "min" = {
      cores = 2
      memory = 1
      core_fraction = 5
      boot_disk_size = 8
    }
    "max" = {
      cores = 2
      memory = 2
      core_fraction = 20
      boot_disk_size = 16
    }
  }
}

variable "vm_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image name"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "VM platform name"
}

variable "vm_security_group" {
  type        = string
  default     = "enpdea5baimkropm5jt7"
  description = "VM platform name"
}

variable "vm_names" {
  type    = list(string)
  default = ["storage", "count-vm", "main", "replica"]
}

locals {
  ssh_public_key = file("/home/alex/.ssh/id_ed25519.pub")
}