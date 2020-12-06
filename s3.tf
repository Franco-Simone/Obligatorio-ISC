resource "aws_s3_bucket" "s3-obl" {
  bucket = "obl-s3"
  acl    = "private"

  tags = {
    Name = "OBL-s3"
    Terraform = "True"
  }
}

resource "aws_s3_access_point" "s3-ap-obl" {
  bucket = aws_s3_bucket.s3-obl.id
  name   = "obl-s3-ap"

  vpc_configuration {
    vpc_id = aws_vpc.vpc-obl.id
  }
}