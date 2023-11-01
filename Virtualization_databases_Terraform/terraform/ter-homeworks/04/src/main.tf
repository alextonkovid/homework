module "vpc_dev" {
  source       = "./vpc"
  name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = ["10.0.1.0/24"] }
  ]
}

module "vpc_prod" {
  source       = "./vpc"
  name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = ["10.0.1.0/24"] },
    { zone = "ru-central1-b", cidr = ["10.0.2.0/24"] },
    { zone = "ru-central1-c", cidr = ["10.0.3.0/24"] },
  ]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.vpc_prod.subnets.ru-central1-a.id ]
  instance_name   = "web"
  instance_count  = 1
  image_family    = "ubuntu-2004-lts"
  public_ip       = true
  
  metadata = {
      user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
      serial-port-enable = 1
  }

}
data "template_file" "cloudinit" {
 template = file("./cloud-init.yml")
   vars = {
    ssh_public_key     = var.ssh_public_key[0]
    ssh_public_key2    = var.ssh_public_key[1]
  }
}


provider "vault" {
 address = "http://192.168.0.25:8200"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
} 

resource "vault_generic_secret" "example" {
  path = "secret/foo"

  data_json = <<EOT
{
  "foo":   "bar",
  "pizza": "cheese"
}
EOT
}