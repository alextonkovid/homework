output "my_output" {
  value = concat(
    [
      for instance in yandex_compute_instance.count-vm :
      {
        name = instance.name
        id = instance.id
        fqdn = instance.fqdn
      }
    ],
    [
      for name, instance in yandex_compute_instance.for_each_vm :
      {
        name = instance.name
        id = instance.id
        fqdn = instance.fqdn
      }
    ],
        [
      {
        name = yandex_compute_instance.storage_vm.name
        id = yandex_compute_instance.storage_vm.id
        fqdn = yandex_compute_instance.storage_vm.fqdn
      }
    ]
  )
}

