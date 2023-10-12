resource "yandex_compute_instance" "netology-count" {
    count      = 2
    name       = "vm-${count.index}"
    platform_id = "standard-v1"

    resources {
        cores         = 2
        memory        = 1
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
