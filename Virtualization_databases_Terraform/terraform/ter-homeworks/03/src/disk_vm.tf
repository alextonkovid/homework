resource "yandex_compute_disk" "disk_vm" {
  count = 3
  name  = "disk-${count.index}"
  size  = 1
}

resource "yandex_compute_instance" "storage_vm" {
  name       = var.vm_names[0]
  platform_id = var.vm_platform_id


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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk_vm
    content {
      device_name = secondary_disk.value.name
      disk_id     = secondary_disk.value.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  metadata = {
    ssh-keys = "user:${local.ssh_public_key}"
    security_group_id = var.vm_security_group
  }
} 

