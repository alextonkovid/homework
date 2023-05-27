variable "vm_configurations" {
  type = list(object({
    vm_name = string
    cpu     = number
    ram     = number
    disk    = number
  }))
  
  default = [
    {
      vm_name = "vm1"
      cpu     = 2
      ram     = 2
      disk    = 10
    },
    {
      vm_name = "vm2"
      cpu     = 2
      ram     = 4
      disk    = 20
    }
  ]
}

locals {
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

resource "yandex_compute_instance" "netology-develop-platform-db" {
  for_each   = { for config in var.vm_configurations : config.vm_name => config }
  name       = each.value.vm_name
  platform_id = "standard-v1"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 10
  }
  
  boot_disk {
    initialize_params {
      image_id = "ubuntu-20-04-lts-v20230522"
      type = "network-hdd"
      size = 5
    } 
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    ssh-keys = "user:${local.ssh_public_key}"
  }
    
}

resource "null_resource" "wait_for_vm1" {
  depends_on = [
    yandex_compute_instance.netology-develop-platform-db["vm1"]
  ]
}

