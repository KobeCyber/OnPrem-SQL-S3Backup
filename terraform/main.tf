provider "aws" {
  region = "us-east-1" # change to your preferred region
}

# ------------------------------
# S3 Bucket #Test3
# ------------------------------

resource "aws_s3_bucket" "sql_backup" {
  bucket = "kobecyber-s3-sqlbackup"

  force_destroy = true

  tags = {
    Name        = "SQL Server Backup Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.sql_backup.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.sql_backup.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.sql_backup.id

  rule {
    id     = "expire-after-10-days"
    status = "Enabled"

    expiration {
      days = 10
    }

    filter {
      prefix = "dailybackup/"
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.sql_backup.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Optional: create the "dailybackup/" folder (via an empty object)
resource "aws_s3_object" "dailybackup_folder" {
  bucket = aws_s3_bucket.sql_backup.id
  key    = "dailybackup/"
  content = ""
}

# ------------------------------
# IAM User for Backup Script
# ------------------------------

resource "aws_iam_user" "sql_backup_user" {
  name = "sql-s3-backup-user"
}

resource "aws_iam_access_key" "sql_backup_key" {
  user = aws_iam_user.sql_backup_user.name
}

data "aws_iam_policy_document" "sql_backup_policy" {
  statement {
    actions = [
      "s3:ListBucket"
    ]

    resources = [
      aws_s3_bucket.sql_backup.arn
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.sql_backup.arn}/*"
    ]
  }
}

resource "aws_iam_user_policy" "sql_backup_inline_policy" {
  name   = "s3-sql-backup-policy"
  user   = aws_iam_user.sql_backup_user.name
  policy = data.aws_iam_policy_document.sql_backup_policy.json
}

# ------------------------------
# Outputs
# ------------------------------

output "s3_bucket_name" {
  value = aws_s3_bucket.sql_backup.bucket
}

output "iam_user_name" {
  value = aws_iam_user.sql_backup_user.name
}

output "access_key_id" {
  value     = aws_iam_access_key.sql_backup_key.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.sql_backup_key.secret
  sensitive = true
}
