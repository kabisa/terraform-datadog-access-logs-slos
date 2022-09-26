variable "env" {
  type = string
}

variable "service" {
  type    = string
  default = ""
}

variable "service_display_name" {
  type    = string
  default = null
}

variable "notification_channel" {
  type = string
}

variable "additional_tags" {
  type    = list(string)
  default = []
}

variable "locked" {
  type    = bool
  default = true
}

variable "name_prefix" {
  type    = string
  default = ""
}

variable "name_suffix" {
  type    = string
  default = ""
}

variable "create_metrics" {
  type    = bool
  default = true
}

variable "slo_filter_str_override" {
  description = "Override for the SLO filter string"
  type        = string
  default     = null
}

variable "slo_metric_prefix" {
  description = "The prefix to use for the computed metrics. Example: apache. if logs are coming from apache"
  validation {
    condition     = trimsuffix(var.slo_metric_prefix, ".") != var.slo_metric_prefix
    error_message = "The slo_metric_prefix should end with a dot."
  }
  type = string
}

variable "log_source_name" {
  description = "The name of the system sending these access logs (eg. Apache, Nginx...)"
  type        = string
}

variable "logs_filter_query" {
  description = "The logs query to filter for portion of access logs that we which to compute SLO's for. We advise to use the source tag for this (eg. source:apache)"
  type        = string
}

variable "logs_service_identifier" {
  type    = string
  default = "service"
  validation {
    condition     = contains(["service", "@http.url_details.host"], var.logs_service_identifier)
    error_message = "The logs_service_identifier should either be service or @http.url_details.host tag."
  }
}
