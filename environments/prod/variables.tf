variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
}

variable "project_name" {
  description = "Project name prefix"
  type        = string
}

variable "alarm_email" {
  description = "Email for security alerts"
  type        = string
}

variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
}
