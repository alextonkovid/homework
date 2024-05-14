module "vpc" {
  source  = "./vpc"
  name = "netology-vpc"
  subnets = {
    // Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
    private  = { zone = "ru-central1-a", cidr = "192.168.10.0/24" },
    // Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
    public = { zone = "ru-central1-b", cidr = "192.168.20.0/24" }
}
}