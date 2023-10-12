# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token                    = "y0_AgAAAABh7FdXAATuwQAAAADTPuj5eE07SS0BR6iLG9pkw_lQcnu1vCY"
  cloud_id                 = "b1g6dhja4p7h085e6s31"
  folder_id                = "b1grdvp13hcnks1eruea"
  zone                     = "ru-central1-a"
}
