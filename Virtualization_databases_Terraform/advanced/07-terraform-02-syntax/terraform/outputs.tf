output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "user_id" {
  value = data.aws_caller_identity.current.user_id
}


output "subnet_id_output" {
  value = aws_subnet.netology_subnet.id
}

output "region_output" {
  value = aws_subnet.netology_subnet.availability_zone
}