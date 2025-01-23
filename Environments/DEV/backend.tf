terraform {
  backend "s3" {
    #bucket = "test799240"
    bucket = var.bucket  # Your S3 bucket name
    key    = "terraform/state/terraform.tfstate"  # Path in the bucket to store the state file
    region = "ap-south-1"  # AWS region where your S3 bucket is located
    encrypt = true  # Encrypt the state file in S3 (recommended)
  }
}
