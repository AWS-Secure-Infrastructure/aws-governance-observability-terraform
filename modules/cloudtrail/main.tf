resource "aws_cloudtrail" "this" {
  name                          = var.name
  s3_bucket_name                = var.s3_bucket_name
  kms_key_id                    = var.kms_key_arn
  enable_log_file_validation    = var.enable_log_file_validation
  is_multi_region_trail         = var.is_multi_region_trail
  include_global_service_events = true
  enable_logging                = true

  cloud_watch_logs_group_arn = var.cloudwatch_log_group_arn
  cloud_watch_logs_role_arn  = var.cloudwatch_log_group_arn != null ? aws_iam_role.cloudtrail_cw_role[0].arn : null

  event_selector {
    read_write_type           = "All"
    include_management_events = true
  }

  tags = var.tags
}

resource "aws_iam_role" "cloudtrail_cw_role" {
  count = var.cloudwatch_log_group_arn != null ? 1 : 0

  name = "${var.name}-cloudtrail-cw-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "cloudtrail_cw_policy" {
  count = var.cloudwatch_log_group_arn != null ? 1 : 0

  name = "${var.name}-cloudtrail-cw-policy"
  role = aws_iam_role.cloudtrail_cw_role[0].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ]
      Resource = "${var.cloudwatch_log_group_arn}:*"
    }]
  })
}
