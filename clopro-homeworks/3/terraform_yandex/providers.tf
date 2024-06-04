terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.117.0"
    }
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  storage_access_key = "YCAJEmo1csTbNFKp2Au2d2gKN"
  storage_secret_key = "YCMFRZVystOV5g-vFZ7rWH_xrbx1tX8iCJvc1Vzt"
}