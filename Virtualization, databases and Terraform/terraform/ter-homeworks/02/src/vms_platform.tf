variable "vm_db_image_name" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM image name"
}


variable "vm_db_platform_id_name" {
  type        = string
  default     = "standard-v1"
  description = "VM platform name"
}

# variable "vm_db_cores" {
#   type        = number
#   default     = 2
#   description = "VM cores quantity"
# }
# variable "vm_db_memory" {
#   type        = number
#   default     = 1
#   description = "VM RAM quantity"
# }
# variable "vm_db_core_fraction" {
#   type        = number
#   default     = 5
#   description = "VM CPU capacity"
# }    