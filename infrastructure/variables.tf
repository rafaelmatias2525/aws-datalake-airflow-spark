variable "aws_region" {
  default = "us-east-1"
}

variable "key_pair_name" {
  description = "Key Pair Name"
  type        = string
  sensitive   = true
}

variable "airflow_subnet_id" {
  description = "AWS Airflow Subnet id"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "AWS VPC id"
  type        = string
  sensitive   = true
}

variable "aws_key_pair" {
  description = "AWS Key Pair"
  type        = string
  sensitive   = true
}