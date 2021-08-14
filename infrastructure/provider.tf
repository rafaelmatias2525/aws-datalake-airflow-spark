# provider AWS
provider "aws" {
  region = var.aws_region
}

# Set state on S3
terraform {
  backend "s3" {
    bucket = "terraform-state-edc-167976530548"
    key    = "state/mod1/terraform.tfstate"
    region = "us-east-1"
  }
}