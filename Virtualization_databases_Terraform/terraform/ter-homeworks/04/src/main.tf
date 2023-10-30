module "vpc_dev" {
  source       = "./vpc"
  network_name = "develop"
  subnet_name = "default"
  zone = "ru-central1-a"
  cidr_blocks = ["10.0.1.0/24"]
}

module "test-vm" {
  source          = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name        = "develop"
  network_id      = module.vpc_dev.network_id
  subnet_zones    = ["ru-central1-a"]
  subnet_ids      = [ module.vpc_dev.subnet_id ]
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
