resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_name
}
resource "yandex_compute_instance" "platform" {
  name        = local.vm_names.web_instance
  platform_id = var.vm_web_platform_id_name
  resources {
    cores         = var.vm_resources["vm_web_resources"].cores
    memory        = var.vm_resources["vm_web_resources"].memory
    core_fraction = var.vm_resources["vm_web_resources"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_ssh_metadata["ssh_enable"].serial-port-enable
    ssh-keys           = var.vm_ssh_metadata["ssh_enable"].ssh-keys
  }

}

resource "yandex_compute_instance" "netology-develop-platform-db" {
  name        = local.vm_names.db_instance
  platform_id = var.vm_db_platform_id_name
  
  resources {
    cores         = var.vm_resources["vm_db_resources"].cores
    memory        = var.vm_resources["vm_db_resources"].memory
    core_fraction = var.vm_resources["vm_db_resources"].core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.vm_ssh_metadata["ssh_enable"].serial-port-enable
    ssh-keys           = var.vm_ssh_metadata["ssh_enable"].ssh-keys
  }

}