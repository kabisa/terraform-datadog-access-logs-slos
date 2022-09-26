resource "datadog_logs_metric" "duration" {
  name  = "${var.slo_metric_prefix}duration"
  count = var.generate_metrics_based_on_logs ? 1 : 0

  compute {
    aggregation_type = "distribution"
    path             = "@duration"
  }
  filter {
    query = var.logs_filter_query
  }
  dynamic "group_by" {
    for_each = toset(local.duration_group_bys)
    iterator = group_by
    content {
      path     = group_by.key
      tag_name = replace(group_by.key, "@", "")
    }
  }
}

resource "datadog_logs_metric" "request_count" {
  name  = "${var.slo_metric_prefix}requests.count"
  count = var.generate_metrics_based_on_logs ? 1 : 0

  compute {
    aggregation_type = "count"
  }
  filter {
    query = var.logs_filter_query
  }
  dynamic "group_by" {
    for_each = toset(local.request_count_group_bys)
    iterator = group_by
    content {
      path     = group_by.key
      tag_name = replace(group_by.key, "@", "")
    }
  }
}

locals {
  bucket_group_bys = var.generate_metrics_based_on_logs ? local.latency_buckets_group_bys : []
  bucket_list      = var.generate_metrics_based_on_logs ? var.latency_buckets : []
  buckets = {
    for bucket in local.bucket_list : tostring(bucket) => bucket * 1000000
  }
}

resource "datadog_logs_metric" "latency_bucket" {
  name     = "${var.slo_metric_prefix}requests.lt.${each.key}ms.count"
  for_each = local.buckets

  compute {
    aggregation_type = "count"
  }
  filter {
    query = "${var.logs_filter_query} @duration:<${each.value}"
  }
  dynamic "group_by" {
    for_each = toset(local.bucket_group_bys)
    iterator = group_by
    content {
      path     = group_by.key
      tag_name = replace(group_by.key, "@", "")
    }
  }
}
