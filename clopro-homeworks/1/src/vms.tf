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
      image_id = "fd8rr96vc85dll9ht225"
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


data "yandex_compute_image" "ubuntu-2004-lts" {
  family = "ubuntu-2004-lts"
}

resource "yandex_compute_instance" "test_vm" {
  zone        = "ru-central1-a"
  name        = "test-network"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2004-lts.image_id
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
    ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBe9Xz59QGm7GXXIBycL98QCHkfzhQUw71xuEhFX8xN alex@new"
  }
}

