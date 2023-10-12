terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}
module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  cloud_name = "netology_vpc"
  subnet_cidr = ["10.0.1.0/24"]
  subnet_zones = "ru-central1-a"
}