variable "latency_slo_enabled" {
  type        = bool
  default     = true
  description = "Note that this monitor requires custom metrics to be present. Those can unfortunately not be created with Terraform yet"
}

variable "latency_slo_note" {
  type    = string
  default = ""
}

variable "latency_slo_docs" {
  type    = string
  default = ""
}

variable "latency_slo_filter_override" {
  type    = string
  default = ""
}

variable "latency_slo_warning" {
  type    = number
  default = null
}

variable "latency_slo_critical" {
  type    = number
  default = 99.9
}

variable "latency_slo_latency_bucket" {
  description = "SLO latency bucket in ms for your logs"
  type        = number
}

variable "latency_slo_alerting_enabled" {
  type    = bool
  default = true
}

variable "latency_slo_timeframe" {
  validation {
    condition     = contains(["7d", "30d", "90d"], var.latency_slo_timeframe)
    error_message = "SLO Timeframe can  be 7,30,90 days. Example: 7d."
  }
  type    = string
  default = "30d"
}

variable "latency_slo_burn_rate_priority" {
  description = "Number from 1 (high) to 5 (low)."

  type    = number
  default = 3
}

variable "latency_slo_burn_rate_warning" {
  type    = number
  default = null
}

variable "latency_slo_burn_rate_critical" {
  type    = number
  default = 10 # 10x burn rate
}

variable "latency_slo_burn_rate_note" {
  type    = string
  default = ""
}

variable "latency_slo_burn_rate_docs" {
  type    = string
  default = "Use burn rates alerts to measure how fast your error budget is being depleted relative to the time window of your SLO. For example, for a 30 day SLO if a burn rate of 1 is sustained, that means the error budget will be fully depleted in exactly 30 days, a burn rate of 2 means in exactly 15 days, etc. Therefore, you could use a burn rate alert to notify you if a burn rate of 10 is measured in the past hour. Burn rate alerts evaluate two time windows: a long window which you specify and a short window that is automatically calculated as 1/12 of your long window. The long window's purpose is to reduce alert flappiness, while the short window's purpose is to improve recovery time. If your threshold is violated in both windows, you will receive an alert."
}

variable "latency_slo_burn_rate_evaluation_period" {
  type    = string
  default = "30d"
}

variable "latency_slo_burn_rate_short_window" {
  type    = string
  default = "5m"
}

variable "latency_slo_burn_rate_long_window" {
  type    = string
  default = "1h"
}

variable "latency_slo_burn_rate_notification_channel_override" {
  type    = string
  default = ""
}

variable "latency_slo_burn_rate_enabled" {
  type    = bool
  default = true
}

variable "latency_slo_burn_rate_alerting_enabled" {
  type    = bool
  default = true
}

variable "latency_slo_custom_numerator" {
  type    = string
  default = ""
}

variable "latency_slo_custom_denominator" {
  type    = string
  default = ""
}
