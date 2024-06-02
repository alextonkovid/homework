resource "yandex_vpc_network" "vpc_netology" {
  name = var.vpc_network_name
}

resource "yandex_vpc_subnet" "private" {
  name          = var.private_subnet_name
  v4_cidr_blocks = [var.private_cidr_block]
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_netology.id
}

resource "yandex_vpc_subnet" "public" {
  name          = var.public_subnet_name
  v4_cidr_blocks = [var.public_cidr_block]
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_netology.id
}