provider "aws" {
  region = "eu-west-1"
}

# S3 bucket for Terraform state
resource "aws_s3_bucket" "tf_state" {
  bucket = "my-tf-state-mk-20250830"

  lifecycle {
    prevent_destroy = true
  }
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.tf_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# DynamoDB table for state locking 
resource "aws_dynamodb_table" "tf_locks" {
  name         = "terraform-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}