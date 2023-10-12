resource "yandex_compute_disk" "netology-develop-platform-disk" {
  count = 3
  name  = "disk-${count.index}"
  size  = 8
}

resource "yandex_compute_instance" "netology-develop-add-disks" {
  name       = "netology-develop-add-disks"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  
  boot_disk {
    initialize_params {
      image_id = "fd8k3a6rj9okseiqrl3k"
      type = "network-hdd"
      size = 8
    } 
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.netology-develop-platform-disk
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
    security_group_id = "enpdea5baimkropm5jt7"
  }
}

resource "local_file" "hosts_cfg" {
  content = templatefile("./hosts.tftpl",

    {server1=yandex_compute_instance.netology-count, 
    server2=yandex_compute_instance.netology-develop-platform-db,
    }  )

  filename = "./ansible.tf"
}