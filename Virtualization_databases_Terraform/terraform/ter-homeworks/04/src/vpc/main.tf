terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_network" "this" {
  name        = var.name
}

resource "yandex_vpc_subnet" "this" {
  for_each       = {for z in var.subnets : z.zone => z}
  name           = "${var.name}-${each.value.zone}"
  v4_cidr_blocks = each.value.cidr
  zone           = each.value.zone
  network_id     = yandex_vpc_network.this.id
}

