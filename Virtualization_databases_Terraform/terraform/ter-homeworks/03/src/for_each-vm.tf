resource "yandex_compute_instance" "netology-develop-platform-db" {
  for_each   = { for config in var.vm_configurations : config.vm_name => config }
  name       = each.value.vm_name
  platform_id = "standard-v1"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
  }
  
  boot_disk {
    initialize_params {
      image_id = "fd8k3a6rj9okseiqrl3k"
      type = "network-hdd"
      size = 8
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
  depends_on = [yandex_compute_instance.netology-count]
}

