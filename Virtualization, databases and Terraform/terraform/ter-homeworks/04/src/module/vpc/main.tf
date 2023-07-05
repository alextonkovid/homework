terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}



# locals {
#   labels = length(keys(var.labels)) >0 ? var.labels: {
#     "env"=var.env_name
#     "project"="undefined"
#   }
# }
#создаем облачную сеть
resource "yandex_vpc_network" "cloud_network" {
  name = var.cloud_name
}

#создаем подсеть
resource "yandex_vpc_subnet" "cloud_subnet" {
  name           = var.cloud_subnet_name
  zone           = var.subnet_zones
  network_id     = yandex_vpc_network.cloud_network.id
  v4_cidr_blocks = var.subnet_cidr
}