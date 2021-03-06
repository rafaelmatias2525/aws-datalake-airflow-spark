resource "aws_s3_bucket" "datalake-edc" {
  bucket = "datalake-edc-staging-zone"
  acl    = "private"

  tags = {
    COURSE = "IGTI-EDC",
    TERRAFORM = "TRUE"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}