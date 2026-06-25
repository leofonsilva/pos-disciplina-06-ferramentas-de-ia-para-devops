provider "aws" {
  region = "us-east-1"
}

# BUCKET S3
resource "aws_s3_bucket" "nexus_apollo_data" {
  bucket = "nexus-apollo-data"
  tags = {
    Name        = "nexus-apollo-data"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

# KMS ENCRYPTION (CKV_AWS_145)
resource "aws_s3_bucket_server_side_encryption_configuration" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = "alias/aws/s3"
      sse_algorithm     = "aws:kms"
    }
  }
}

# PUBLIC ACCESS BLOCK (CKV2_AWS_6)
resource "aws_s3_bucket_public_access_block" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# VERSIONING (CKV_AWS_21)
resource "aws_s3_bucket_versioning" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  versioning_configuration {
    status = "Enabled"
  }
}

# LOGGING (CKV_AWS_18)
resource "aws_s3_bucket_logging" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  target_bucket = "nexus-logs"
  target_prefix = "nexus-apollo-data/"
}

# LIFECYCLE (CKV2_AWS_61 e CKV_AWS_300)
resource "aws_s3_bucket_lifecycle_configuration" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  rule {
    id     = "expire-old-versions"
    status = "Enabled"
    
    noncurrent_version_expiration {
      noncurrent_days = 30
    }

    abort_incomplete_multipart_upload {
      days_after_initiation = 7
    }
  }
}

# CROSS-REGION REPLICATION (CKV_AWS_144)
resource "aws_s3_bucket_replication_configuration" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  role   = "arn:aws:iam::ACCOUNT_ID:role/nexus-replication-role"
  rule {
    id     = "replicate-to-backup"
    status = "Enabled"
    destination {
      bucket        = "arn:aws:s3:::nexus-apollo-data-backup"
      storage_class = "STANDARD"
    }
  }
}

# EVENT NOTIFICATIONS (CKV2_AWS_62)
resource "aws_s3_bucket_notification" "nexus_apollo_data" {
  bucket = aws_s3_bucket.nexus_apollo_data.bucket
  queue {
    queue_arn = "arn:aws:sqs:us-east-1:ACCOUNT_ID:nexus-queue"
    events    = ["s3:ObjectCreated:*"]
  }
}
