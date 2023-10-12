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
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23 alex@new"
#   description = "ssh-keygen -t ed25519"
# }

variable "vm_web_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image name"
}


variable "vm_web_platform_id_name" {
  type        = string
  default     = "standard-v1"
  description = "VM platform name"
}

# variable "vm_web_cores" {
#   type        = number
#   default     = 2
#   description = "VM cores quantity"
# }
# variable "vm_web_memory" {
#   type        = number
#   default     = 1
#   description = "VM RAM quantity"
# }
# variable "vm_web_core_fraction" {
#   type        = number
#   default     = 5
#   description = "VM CPU capacity"
# }    

variable "db" {
    type      = string
    default   = "db"
}
variable "web" {
    type      = string
    default   = "web"
}

variable "vm_resources" {
  type = map(object({
    cores = number
    memory = number
    core_fraction = number
  }))
  default = {
    "vm_web_resources" = {
      cores = 2
      memory = 1
      core_fraction = 5
    }
    "vm_db_resources" = {
      cores = 2
      memory = 2
      core_fraction = 20
    }
  }
}


variable "vm_ssh_metadata" {
  type = map(object({
    serial-port-enable = number
    ssh-keys = string
  }))
  default = {
    "ssh_enable" = {
      ssh-keys           = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23 alex@new"
      serial-port-enable = 1
    }
  }
}