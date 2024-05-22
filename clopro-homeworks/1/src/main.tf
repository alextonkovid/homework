module "vpc" {
  source  = "./vpc"
  name = "netology-vpc"
  subnets = {
    public= { zone = "ru-central1-a", cidr = "192.168.20.0/24"},
    private = { zone = "ru-central1-b", cidr = "192.168.10.0/24"}
}
}

resource "yandex_vpc_route_table" "nat-instance-route" {
  name       = "nat-instance-route"
  network_id = module.vpc.vpc_id
  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = "192.168.10.254"
  }
}