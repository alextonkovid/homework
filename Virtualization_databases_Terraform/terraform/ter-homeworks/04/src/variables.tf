###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

###common vars

variable "vms_ssh_root_key" {
  type        = string
  default     = "your_ssh_ed25519_key"
  description = "ssh-keygen -t ed25519"
}

###example vm_web var
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "example vm_web_ prefix"
}

###example vm_db var
variable "vm_db_name" {
  type        = string
  default     = "netology-develop-platform-db"
  description = "example vm_db_ prefix"
}


# variable "ssh_public_key" {
#   type = map(object({
#     key = string
#   }))
#   default = {
#     "first" = {
#       key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkwWe0LhCjvUvF30Ws3As9rQIRaoq5hLSoNew0TDW/EFEx7XCFPOWq1QF2HF+2YtSrnI3JJLh18GLrCXPXjjLsITSnL6SZm8LoKwd0gJer50OMCGq1ukN/LCH7mUixeNByIUb7QGOYYA6iTuN3WUzZNwPw1fW1xDOnb84N+epUY1W+A9Md2YyjXyRjeybb/s5jjg6G4NkGSdTuJo42t2SVJCTNr95OzJGTTRYvAHepx4UCqwD0JnKLJhi0vY8hkpKFIINV1wUvaDlhwSkX0bY0/w7159E7bq3zHcazk5hdHhlTYFEmliuRc6QIU2vAazZWT/aGdJFtP7uvzgXwNd5I6ZCusXlHAeoeoSzuZtfQKMYLnwXEzbnyfON/huM/cPioyasyV+BlEnIGaDhlC+aWcVVBwW3U75U53eFu6Ib/8U+5k/DPA6bxDl1ZBfqSHUhYuuz3a1DvLXTr4A7MHQV1JRa2F11LazzyXEY6m2rG3DZDAkBQ89tAXrTDYZiZ9P0= alex@new",
#     }
#     "second" = {
#       key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23 alex@new"
#     }
#   }
# }

variable "ssh_public_key" {
  default     = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkwWe0LhCjvUvF30Ws3As9rQIRaoq5hLSoNew0TDW/EFEx7XCFPOWq1QF2HF+2YtSrnI3JJLh18GLrCXPXjjLsITSnL6SZm8LoKwd0gJer50OMCGq1ukN/LCH7mUixeNByIUb7QGOYYA6iTuN3WUzZNwPw1fW1xDOnb84N+epUY1W+A9Md2YyjXyRjeybb/s5jjg6G4NkGSdTuJo42t2SVJCTNr95OzJGTTRYvAHepx4UCqwD0JnKLJhi0vY8hkpKFIINV1wUvaDlhwSkX0bY0/w7159E7bq3zHcazk5hdHhlTYFEmliuRc6QIU2vAazZWT/aGdJFtP7uvzgXwNd5I6ZCusXlHAeoeoSzuZtfQKMYLnwXEzbnyfON/huM/cPioyasyV+BlEnIGaDhlC+aWcVVBwW3U75U53eFu6Ib/8U+5k/DPA6bxDl1ZBfqSHUhYuuz3a1DvLXTr4A7MHQV1JRa2F11LazzyXEY6m2rG3DZDAkBQ89tAXrTDYZiZ9P0= alex@new",
  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBe9Xz59QGm7GXXIBycL98QCHkfzhQUw71xuEhFX8xN alex@new"]
  description = "description"
}



#   variable "ssh_public_key" {
#   default     = <<EOM
#   - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkwWe0LhCjvUvF30Ws3As9rQIRaoq5hLSoNew0TDW/EFEx7XCFPOWq1QF2HF+2YtSrnI3JJLh18GLrCXPXjjLsITSnL6SZm8LoKwd0gJer50OMCGq1ukN/LCH7mUixeNByIUb7QGOYYA6iTuN3WUzZNwPw1fW1xDOnb84N+epUY1W+A9Md2YyjXyRjeybb/s5jjg6G4NkGSdTuJo42t2SVJCTNr95OzJGTTRYvAHepx4UCqwD0JnKLJhi0vY8hkpKFIINV1wUvaDlhwSkX0bY0/w7159E7bq3zHcazk5hdHhlTYFEmliuRc6QIU2vAazZWT/aGdJFtP7uvzgXwNd5I6ZCusXlHAeoeoSzuZtfQKMYLnwXEzbnyfON/huM/cPioyasyV+BlEnIGaDhlC+aWcVVBwW3U75U53eFu6Ib/8U+5k/DPA6bxDl1ZBfqSHUhYuuz3a1DvLXTr4A7MHQV1JRa2F11LazzyXEY6m2rG3DZDAkBQ89tAXrTDYZiZ9P0= alex@new
#       - ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMHYoMY6UrrAOFqB3drIhp+1QEX4ve6RbETRIpyYTz23 alex@new 
# EOM
#   description = "example vm_web_ prefix"
# }

# variable "subnets" {
#   type = list(object({
#     zone = string
#     cidr_blocks     = string
#   }))
# }