# resource "aws_instance" "netology_instance" {
#   ami           = "ami-01974e77aa2dcb43d" 
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.public.id
#   key_name = "terraform_ec2_key"
#   tags = {
#     Name = "netology_instance"
#   }

#   security_groups = [aws_security_group.netology_security_group.id]
# }

# resource "aws_key_pair" "terraform_ec2_key" {
# 	key_name = "terraform_ec2_key"
# 	public_key = "${file("/home/alex/.ssh/id_ed25519.pub")}"
# }

# resource "aws_instance" "netology_instance_private" {
#   ami           = "ami-01974e77aa2dcb43d" 
#   instance_type = "t2.micro"
#   subnet_id = aws_subnet.private.id
#   key_name = "terraform_ec2_key"
#   tags = {
#     Name = "netology_instance_private"
#   }

#   security_groups = [aws_security_group.netology_security_group.id]
# }

resource "aws_s3_bucket" "netology-s3" {
  bucket = "netology-s3-bucket"
}

resource "aws_s3_bucket_ownership_controls" "owner-control" {
  bucket = aws_s3_bucket.netology-s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "access-control" {
  bucket = aws_s3_bucket.netology-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  bucket = aws_s3_bucket.netology-s3.id
  acl    = "public-read"
}
resource "aws_s3_object" "object" {
  bucket = "netology-s3-bucket"
  key    = "image"
  source = "/mnt/e/DevOps/homework/clopro-homeworks/2/terraform_yandex/image.png"
}