resource "aws_cloudwatch_log_group" "services" {
  name              = "services"
  retention_in_days = 3
}
