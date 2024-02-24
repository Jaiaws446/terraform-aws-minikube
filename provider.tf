terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0" # AWS provider version, not terraform version
    }
  }

  backend "s3" {
    bucket = "jaiaws446-remote-state"
    key    = "minikube"
    region = "us-east-1"
    dynamodb_table = "jaiaws446-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}