## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_test-vm"></a> [test-vm](#module\_test-vm) | git::https://github.com/udjin10/yandex_compute_instance.git | main |
| <a name="module_vpc_dev"></a> [vpc\_dev](#module\_vpc\_dev) | ./vpc | n/a |

## Resources

| Name | Type |
|------|------|
| [template_file.cloudinit](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_id"></a> [cloud\_id](#input\_cloud\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id | `string` | n/a | yes |
| <a name="input_default_cidr"></a> [default\_cidr](#input\_default\_cidr) | https://cloud.yandex.ru/docs/vpc/operations/subnet-create | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_default_zone"></a> [default\_zone](#input\_default\_zone) | https://cloud.yandex.ru/docs/overview/concepts/geo-scope | `string` | `"ru-central1-a"` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id | `string` | n/a | yes |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | description | `list` | <pre>[<br>  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkwWe0LhCjvUvF30Ws3As9rQIRaoq5hLSoNew0TDW/EFEx7XCFPOWq1QF2HF+2YtSrnI3JJLh18GLrCXPXjjLsITSnL6SZm8LoKwd0gJer50OMCGq1ukN/LCH7mUixeNByIUb7QGOYYA6iTuN3WUzZNwPw1fW1xDOnb84N+epUY1W+A9Md2YyjXyRjeybb/s5jjg6G4NkGSdTuJo42t2SVJCTNr95OzJGTTRYvAHepx4UCqwD0JnKLJhi0vY8hkpKFIINV1wUvaDlhwSkX0bY0/w7159E7bq3zHcazk5hdHhlTYFEmliuRc6QIU2vAazZWT/aGdJFtP7uvzgXwNd5I6ZCusXlHAeoeoSzuZtfQKMYLnwXEzbnyfON/huM/cPioyasyV+BlEnIGaDhlC+aWcVVBwW3U75U53eFu6Ib/8U+5k/DPA6bxDl1ZBfqSHUhYuuz3a1DvLXTr4A7MHQV1JRa2F11LazzyXEY6m2rG3DZDAkBQ89tAXrTDYZiZ9P0= alex@new",<br>  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHBe9Xz59QGm7GXXIBycL98QCHkfzhQUw71xuEhFX8xN alex@new"<br>]</pre> | no |
| <a name="input_token"></a> [token](#input\_token) | OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token | `string` | n/a | yes |
| <a name="input_vm_db_name"></a> [vm\_db\_name](#input\_vm\_db\_name) | example vm\_db\_ prefix | `string` | `"netology-develop-platform-db"` | no |
| <a name="input_vm_web_name"></a> [vm\_web\_name](#input\_vm\_web\_name) | example vm\_web\_ prefix | `string` | `"netology-develop-platform-web"` | no |
| <a name="input_vms_ssh_root_key"></a> [vms\_ssh\_root\_key](#input\_vms\_ssh\_root\_key) | ssh-keygen -t ed25519 | `string` | `"your_ssh_ed25519_key"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | VPC network&subnet name | `string` | `"develop"` | no |

## Outputs
