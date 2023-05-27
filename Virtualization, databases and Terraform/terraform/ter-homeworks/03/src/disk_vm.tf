resource "yandex_compute_disk" "netology-develop-platform-disk" {
  count = 3
  name  = "disk-${count.index}"
  size  = 1
}
