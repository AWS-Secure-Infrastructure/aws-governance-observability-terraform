output "log_group_name" {
  value = aws_cloudwatch_log_group.this.name
}

output "sns_topic_arn" {
  value = aws_sns_topic.security_alerts.arn
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.this.arn
}
