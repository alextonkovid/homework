output "network_id" {
  value = yandex_vpc_network.cloud_network.id
}

output "cloud_subnet_id" {
  value = yandex_vpc_subnet.cloud_subnet.id
}
