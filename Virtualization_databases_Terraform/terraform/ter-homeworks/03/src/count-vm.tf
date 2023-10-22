resource "yandex_compute_instance" "count-vm" {
  count      = 2
  name       = "${(var.vm_names[1])}-${count.index}"
  platform_id = var.vm_platform_id

  labels = { 
    ansible-group = "web"
  }

  resources {
      cores         = var.vm_resources.min.cores
      memory        = var.vm_resources.min.memory
      core_fraction = var.vm_resources.min.core_fraction
  }
  boot_disk {
  initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type = "network-hdd"
      size = var.vm_resources.min.boot_disk_size
      }
  }
  network_interface {
  subnet_id = yandex_vpc_subnet.develop.id
  security_group_ids = [yandex_vpc_security_group.example.id]
  nat       = true
  }
  
  metadata = {
      ssh-keys = "user:${local.ssh_public_key}"
  }
  
}
