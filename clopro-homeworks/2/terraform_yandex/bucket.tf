resource "yandex_storage_bucket" "netology-bucket-os" {
  bucket = "netology-bucket-os"
  website {
    index_document = "index"
    error_document = "error"
  }


  folder_id = var.folder_id

  default_storage_class = "COLD"

  anonymous_access_flags {
    read = true
    list = true
  }
}
resource "yandex_storage_object" "netology-picture" {
  bucket = "netology-bucket-os"
  key    = "netology"
  source = "/mnt/e/DevOps/homework/clopro-homeworks/2/terraform_yandex/image.png"
  acl = "public-read"
}