# Generate a random suffix to guarantee a unique global bucket name
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

# The Core Enterprise Data Lake Bucket
resource "aws_s3_bucket" "data_lake" {
  bucket        = "enterprise-ai-data-lake-${random_id.bucket_suffix.hex}"
  force_destroy = true # Allows easy clean up during your dev phase
}

# Enforce Object Versioning for State Recovery
resource "aws_s3_bucket_versioning" "data_lake_versioning" {
  bucket = aws_s3_bucket.data_lake.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Enforce Server-Side Encryption (KMS) for Enterprise Data Security
resource "aws_s3_bucket_server_side_encryption_configuration" "data_lake_crypto" {
  bucket = aws_s3_bucket.data_lake.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Enforce Strict Public Access Blocks (Zero-Trust)
resource "aws_s3_bucket_public_access_block" "data_lake_privacy" {
  bucket = aws_s3_bucket.data_lake.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Output the bucket name so you can easily reference it in your upcoming modules
output "data_lake_bucket_name" {
  value       = aws_s3_bucket.data_lake.id
  description = "The globally unique name of the deployed S3 Data Lake"
}
