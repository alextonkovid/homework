# resource "aws_placement_group" "netology-group" {
#   name     = "netology-group"
#   strategy = "cluster"
# }

resource "aws_autoscaling_group" "netology-autoscaling-group" {
  name                      = "netology-group"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 3
  force_delete              = true
#   placement_group           = aws_placement_group.netology-group.id
  launch_configuration      = aws_launch_configuration.netology-launch-conf.name
  vpc_zone_identifier       = [aws_subnet.public.id]

  instance_maintenance_policy {
    min_healthy_percentage = 90
    max_healthy_percentage = 120
  }

#   initial_lifecycle_hook {
#     name                 = "foobar"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = jsonencode({
#       foo = "bar"
#     })

#     notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

#   tag {
#     key                 = "foo"
#     value               = "bar"
#     propagate_at_launch = true
#    }

#   timeouts {
#     delete = "15m"
#   }

#   tag {
#     key                 = "lorem"
#     value               = "ipsum"
#     propagate_at_launch = false
#   }
}