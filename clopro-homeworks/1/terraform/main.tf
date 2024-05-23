
resource "yandex_vpc_network" "vpc_netology" {
  name = var.vpc_network_name
}

resource "yandex_vpc_subnet" "private" {
  name          = var.private_subnet_name
  v4_cidr_blocks = [var.private_cidr_block]
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_netology.id
  route_table_id = yandex_vpc_route_table.netology_rt_a.id
}

resource "yandex_vpc_subnet" "public" {
  name          = var.public_subnet_name
  v4_cidr_blocks = [var.public_cidr_block]
  zone           = var.zone
  network_id     = yandex_vpc_network.vpc_netology.id
}

resource "yandex_vpc_gateway" "default" {
  name = "egress-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "netology_rt_a" {
  network_id = yandex_vpc_network.vpc_netology.id

  static_route {
    destination_prefix = "0.0.0.0/24"
    next_hop_address   = var.nat_ip_address
  }

  # Uncomment this block if you need a default route through the gateway
  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.default.id
  }
}
