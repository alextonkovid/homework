data "aws_ami" "fedora" {
  most_recent = true

  filter {
    name   = "name"
    values = ["LAMP_Fedora-Cloud-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = [ "hvm"]
  }

}

output "ami" {
   value = data.aws_ami.fedora.id
}
resource "aws_launch_configuration" "netology-launch-conf" {
  name          = "web_config"
  image_id      = data.aws_ami.fedora.id
  instance_type = "t2.micro"
}

resource "aws_launch_template" "foo" {
  name = "foo"

  block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size = 20
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }

  cpu_options {
    core_count       = 2
    threads_per_core = 1
  }

  credit_specification {
    cpu_credits = "standard"
  }

  disable_api_stop        = true
  disable_api_termination = true

  ebs_optimized = true

  elastic_inference_accelerator {
    type = "eia1.medium"
  }

  instance_type = "t2.micro"

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = var.default_zone
  }

  vpc_security_group_ids = [aws_security_group.netology_security_group.id]

  user_data = filebase64("${path.module}/index-html.sh")
}