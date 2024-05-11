variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
}

variable "subnets" {
  type    = list(object({
    zone           = string
    cidr = list(string)
  }))
  default = [
    {
      zone           = "ru-central1-a"
      cidr = ["10.130.0.0/24"]
    },
    {
      zone           = "ru-central1-b"
      cidr = ["10.129.0.0/24"]
    },
    {
      zone           = "ru-central1-c"
      cidr = ["10.128.0.0/24"]
    }
  ]
}
