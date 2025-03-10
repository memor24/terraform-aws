provider "aws" {
  region = "us-west-2"
}

module "cloudwatch_log_group" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-group"

  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  tags = {
    Environment = var.environment
    Application = "my-app"
  }
}

module "cloudwatch_log_stream" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-stream"

  name           = var.log_stream_name
  log_group_name = module.cloudwatch_log_group[0].name
}

# sample log metric filter, and alarm based on that filter

module "cloudwatch_log_metric_filter" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-metric-filter"
  
  name = "error-count"
  log_group_name = module.cloudwatch_log_group[0].name
  pattern = "[timestamp, request_id, ip, error=\"*Exception\"]" # search pattern to extract metrics from log events
  metric_transformation_name= "error-count"                                      # metric to be created from the log event filter
  metric_transformation_namespace = "myapp-log-metrics"
}

module "cloudwatch_metric-alarm" {
source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"

  alarm_name                = "error-count-notify"
  alarm_description         = "Alarm when error count exceeds 1 within 1 minute"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "error-count"
  namespace                 = "myapp-log-metrics"
  period                    = "60" # 1 minute
  statistic                 = "Sum"
  threshold                 = "1"
  actions_enabled           = "true"
  alarm_actions             = [module.sns_topic.topic_arn]
}

module "sns_topic" {
  source = "terraform-aws-modules/sns/aws"

  # policy = data.aws_iam_policy_document.sns_topic.json

  name = "myapp-alarms-notification"
  subscriptions = [
    {
      protocol = "email"
      endpoint = "myemail@test.com"
    }
  ]
  tags = {
    Environment = var.environment
    Application = "my-app"
  }

}