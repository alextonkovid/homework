output "route-table-id" {
  value = yandex_vpc_route_table.netology_rt_a.id
}

output "vm-public-ip" {
  value = yandex_compute_instance.vm_public_ip.network_interface.0.nat_ip_address
}