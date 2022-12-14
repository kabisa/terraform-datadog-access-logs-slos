locals {
  error_slo_filter = coalesce(
    var.error_slo_filter_override,
    local.filter_str
  )
  error_slo_numerator = coalesce(
    var.error_slo_numerator_override,
    "sum:${var.slo_metric_prefix}requests.count{${local.error_slo_filter}${var.error_slo_error_filter}}.as_count()"
  )
  error_slo_denominator = coalesce(
    var.error_slo_denominator_override,
    "sum:${var.slo_metric_prefix}requests.count{${local.error_slo_filter}}.as_count()"
  )
  error_slo_burn_rate_notification_channel = try(coalesce(
    var.error_slo_burn_rate_notification_channel_override,
    var.notification_channel
  ), "")
  error_slo_burn_rate_enabled = var.error_slo_enabled && var.error_slo_burn_rate_enabled
  error_slo_id                = local.error_slo_burn_rate_enabled ? datadog_service_level_objective.error_slo[0].id : ""
}

resource "datadog_service_level_objective" "error_slo" {
  count       = var.error_slo_enabled ? 1 : 0
  name        = "${local.service_display_name} - ${var.log_source_name} - Error SLO"
  type        = "metric"
  description = "Errors SLO for ${local.service_display_name}"

  thresholds {
    timeframe = var.error_slo_timeframe
    target    = var.error_slo_critical
    warning   = var.error_slo_warning
  }

  query {
    numerator   = local.error_slo_numerator
    denominator = local.error_slo_denominator
  }

  tags = local.normalized_tags
}

module "error_slo_burn_rate" {
  source  = "kabisa/generic-monitor/datadog"
  version = "1.0.0"

  name  = "${var.log_source_name} - Error SLO - Burn Rate"
  query = "burn_rate(\"${local.error_slo_id}\").over(\"${var.error_slo_burn_rate_evaluation_period}\").long_window(\"${var.error_slo_burn_rate_long_window}\").short_window(\"${var.error_slo_burn_rate_short_window}\") > ${var.error_slo_burn_rate_critical}"


  alert_message    = "${local.service_display_name} service is burning through its Error Budget. The percentage of 5XX status codes is {{threshold}}x higher than expected"
  recovery_message = "${local.service_display_name} service burn rate has recovered"
  type             = "slo alert"

  # monitor level vars
  enabled            = var.error_slo_enabled && var.error_slo_burn_rate_enabled
  alerting_enabled   = var.error_slo_burn_rate_alerting_enabled
  warning_threshold  = var.error_slo_burn_rate_warning
  critical_threshold = var.error_slo_burn_rate_critical
  priority           = var.error_slo_burn_rate_priority
  docs               = var.error_slo_burn_rate_docs
  note               = var.error_slo_burn_rate_note

  # module level vars
  env                  = var.env
  service              = var.service
  service_display_name = var.service_display_name
  notification_channel = local.error_slo_burn_rate_notification_channel
  additional_tags      = var.additional_tags
  locked               = var.locked
  name_prefix          = var.name_prefix
  name_suffix          = var.name_suffix
}
