resource "yandex_storage_bucket" "netology-bucket-os" {
  bucket = "netology-bucket-os"
  # acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  https {
    certificate_id = "fpq17fl929vklb7c2ndr"
  }

  folder_id = var.folder_id

  default_storage_class = "COLD"

  anonymous_access_flags {
    read = true
    list = true
  }

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.netology-symetric-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}
resource "yandex_storage_object" "netology-picture" {
  bucket = "netology-bucket-os"
  key    = "netology"
  source = "/mnt/e/DevOps/homework/clopro-homeworks/2/terraform_yandex/image.png"
  acl = "public-read"
}

resource "yandex_storage_object" "netology-html" {
  bucket = "netology-bucket-os"
  key    = "index.html"
  source = "/mnt/e/DevOps/homework/clopro-homeworks/3/terraform_yandex/index.html"
  acl = "public-read"
}

resource "yandex_kms_symmetric_key" "netology-symetric-key" {
  name              = "netology-symetric-key"
  description       = "description for key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h" // equal to 1 year
}