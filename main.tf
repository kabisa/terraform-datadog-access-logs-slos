locals {
  filters = [
    "env:${var.env}",
    # var.logs_service_identifier == "service" ? "service:${var.service}" : "url_host:${var.url_host}"
    "${var.logs_service_identifier}:${var.service}"
  ]
  tag_specials_regex = "/[^a-z0-9\\-_:.\\/]/"

  tags = concat(
    [
      "terraform:true",
      "env:${var.env}",
      "${var.logs_service_identifier}:${var.service}"
    ],
    var.additional_tags
  )

  # Normalize all the tags according to best practices defined by Datadog. The
  # following changes are made:
  #
  # * Make all characters lowercase.
  # * Replace special characters with an underscore.
  # * Remove duplicate underscores.
  # * Remove any non-letter leading characters.
  # * Remove any trailing underscores.
  #
  # See: https://docs.datadoghq.com/developers/guide/what-best-practices-are-recommended-for-naming-metrics-and-tags
  normalized_tags = [
    for tag
    in local.tags :
    replace(
      replace(
        replace(
          replace(lower(tag), local.tag_specials_regex, "_")
          ,
          "/_+/",
          "_"
        ),
        "/^[^a-z]+/",
        ""
      ),
      "/_+$/",
      ""
    )
  ]
  normalized_filters = [
    for tag
    in local.filters :
    replace(
      replace(
        replace(
          replace(lower(tag), local.tag_specials_regex, "_")
          ,
          "/_+/",
          "_"
        ),
        "/^[^a-z]+/",
        ""
      ),
      "/_+$/",
      ""
    )
  ]
  filter_str           = var.slo_filter_str_override != null ? var.slo_filter_str_override : join(",", local.normalized_filters)
  service_display_name = var.service_display_name != null ? var.service_display_name : var.service


  duration_group_bys = coalesce(var.duration_group_bys_override, [
    var.logs_service_identifier,
    "status",
    "env",
    "host"
  ])
  request_count_group_bys = coalesce(var.request_count_group_bys_override, [
    var.logs_service_identifier,
    "status",
    "env",
    "host"
  ])
  latency_buckets_group_bys = coalesce(var.latency_buckets_group_bys_override, [
    var.logs_service_identifier,
    "status",
    "env",
    "host"
  ])
}
