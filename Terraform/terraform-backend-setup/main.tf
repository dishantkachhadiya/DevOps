terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"		
    }  
  }
}

provider "aws" {
  region = "us-east-1" 
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "dishant-kachhadiya-tfstate-2026" # must be globally unique across ALL AWS accounts
   
  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}
