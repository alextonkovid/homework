resource "yandex_compute_instance" "nat-instanse" {
  name        = "nat-instance"
  zone        = "ru-central1-b"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd80mrhj8fl2oe87o4e1"
      type     = "network-hdd"
      size     = 20
    }
  }
    network_interface {
    subnet_id = module.vpc.subnets_locations.private
    ipv4 = true
    ip_address = "192.168.10.254"
  }

}

resource "yandex_compute_instance" "vm-public-ip" {
  zone        = "ru-central1-a"
  name        = "vm-public-ip"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8idq8k33m9hlj0huli"
      type     = "network-hdd"
      size     = 20
    }

  }
    scheduling_policy { preemptible = true }

  network_interface {
    subnet_id = module.vpc.subnets_locations.public
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23"
  }
}


resource "yandex_compute_instance" "vm-private-ip" {
  zone        = "ru-central1-b"
  name        = "vm-private-ip"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd8idq8k33m9hlj0huli"
      type     = "network-hdd"
      size     = 20
    }
  }

  scheduling_policy { 
    preemptible = true 
  }

  network_interface {
    subnet_id = module.vpc.subnets_locations.private
    ipv4 = true
    ip_address = "192.168.10.10"
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23"
  }
}

output "vm-public-ip" {
  value = yandex_compute_instance.vm-public-ip.network_interface.0.nat_ip_address
}
