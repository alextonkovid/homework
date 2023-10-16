resource "yandex_compute_instance" "for_each_vm" {
  for_each   = { for config in var.vm_configurations : config.vm_name => config }
  name       = each.value.vm_name
  platform_id = var.vm_platform_id

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = 5
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
    nat       = true
  }
  metadata = {
    ssh-keys = "user:${local.ssh_public_key}"
  }
    
}

resource "null_resource" "wait_for_vm1" {
  depends_on = [yandex_compute_instance.count-vm]
}
