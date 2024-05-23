resource "yandex_compute_instance" "nat_instance" {
  name = "nat-instance"
  zone = var.zone
  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_image_id
      type     = var.boot_disk_type
      size     = var.boot_disk_size
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ipv4       = true
    ip_address = var.nat_ip_address
  }
  metadata = {
    serial-port-enable = 1
    ssh-keys           = var.ssh_keys
  }
}

resource "yandex_compute_instance" "vm_public_ip" {
  zone = var.zone
  name = "vm-public-ip"
  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_image_id
      type     = var.boot_disk_type
      size     = var.boot_disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = var.ssh_keys
  }
}

resource "yandex_compute_instance" "vm_private_ip" {
  zone = var.zone
  name = "vm-private-ip"
  resources {
    cores         = var.instance_cores
    memory        = var.instance_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.boot_disk_image_id
      type     = var.boot_disk_type
      size     = var.boot_disk_size
    }
  }

  scheduling_policy { 
    preemptible = true 
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.private.id
    ipv4       = true
    ip_address = "192.168.20.10"
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = var.ssh_keys
  }
}
