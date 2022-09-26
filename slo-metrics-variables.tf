variable "generate_metrics_based_on_logs" {
  type    = bool
  default = true
}

variable "duration_group_bys_override" {
  type    = list(string)
  default = null
}

variable "request_count_group_bys_override" {
  type    = list(string)
  default = null
}

variable "latency_buckets_group_bys_override" {
  type    = list(string)
  default = null
}

variable "latency_buckets" {
  description = "Latency buckets in ms"
  type        = list(number)
  default     = [100, 250, 500, 1000, 2500, 5000, 10000]
}
