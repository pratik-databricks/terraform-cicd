locals {
  region = var.region
}
terraform {
  backend "s3" {

    bucket = "tf-db-bucket"
    key    = "statefiles/aws-infra.tfstate"
    dynamodb_table = "tf-db-table"
    region = "us-west-2"
  }
}



provider "aws" {
  region  = var.region
}


variable "prefix" {
}

variable "tags" {
  type = map(string)
}

variable "region" {
}

module "aws-resources" {
  source = "../../modules/aws-infra"
  prefix = var.prefix
  tags = var.tags
}


output "s3_bucket_name" {
  value = module.aws-resources.s3_bucket_name
}