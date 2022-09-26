
![Datadog](https://imgix.datadoghq.com/img/about/presskit/logo-v/dd_vertical_purple.png)

[//]: # (This file is generated. Do not edit, module description can be added by editing / creating module_description.md)

# Terraform module for Datadog Access Logs Slos

This module is part of a larger suite of modules that provide alerts in Datadog.
Other modules can be found on the [Terraform Registry](https://registry.terraform.io/search/modules?namespace=kabisa&provider=datadog)

We have two base modules we use to standardise development of our Monitor Modules:
- [generic monitor](https://github.com/kabisa/terraform-datadog-generic-monitor) Used in 90% of our alerts
- [service check monitor](https://github.com/kabisa/terraform-datadog-service-check-monitor)

Modules are generated with this tool: https://github.com/kabisa/datadog-terraform-generator


[Module Variables](#module-variables)

Monitors:

| Monitor name    | Default enabled | Priority | Query                  |
|-----------------|------|----|------------------------|
| [Errors Slo](#errors-slo) | True | 3  | `burn_rate(\"${local.error_slo_id}\").over(\"${var.error_slo_burn_rate_evaluation_period}\").long_window(\"${var.error_slo_burn_rate_long_window}\").short_window(\"${var.error_slo_burn_rate_short_window}\") > ${var.error_slo_burn_rate_critical}` |
| [Latency Slo](#latency-slo) | True | 3  | `burn_rate(\"${local.latency_slo_id}\").over(\"${var.latency_slo_burn_rate_evaluation_period}\").long_window(\"${var.latency_slo_burn_rate_long_window}\").short_window(\"${var.latency_slo_burn_rate_short_window}\") > ${var.latency_slo_burn_rate_critical}` |

# Getting started developing
[pre-commit](http://pre-commit.com/) was used to do Terraform linting and validating.

Steps:
   - Install [pre-commit](http://pre-commit.com/). E.g. `brew install pre-commit`.
   - Run `pre-commit install` in this repo. (Every time you clone a repo with pre-commit enabled you will need to run the pre-commit install command)
   - That’s it! Now every time you commit a code change (`.tf` file), the hooks in the `hooks:` config `.pre-commit-config.yaml` will execute.

## Errors Slo

Use burn rates alerts to measure how fast your error budget is being depleted relative to the time window of your SLO. For example, for a 30 day SLO if a burn rate of 1 is sustained, that means the error budget will be fully depleted in exactly 30 days, a burn rate of 2 means in exactly 15 days, etc. Therefore, you could use a burn rate alert to notify you if a burn rate of 10 is measured in the past hour. Burn rate alerts evaluate two time windows: a long window which you specify and a short window that is automatically calculated as 1/12 of your long window. The long window's purpose is to reduce alert flappiness, while the short window's purpose is to improve recovery time. If your threshold is violated in both windows, you will receive an alert.

Query:
```terraform
burn_rate(\"${local.error_slo_id}\").over(\"${var.error_slo_burn_rate_evaluation_period}\").long_window(\"${var.error_slo_burn_rate_long_window}\").short_window(\"${var.error_slo_burn_rate_short_window}\") > ${var.error_slo_burn_rate_critical}
```

| variable                                          | default                                  | required | description                                                                                          |
|---------------------------------------------------|------------------------------------------|----------|------------------------------------------------------------------------------------------------------|
| error_slo_enabled                                 | True                                     | No       |                                                                                                      |
| error_slo_note                                    | ""                                       | No       |                                                                                                      |
| error_slo_docs                                    | ""                                       | No       |                                                                                                      |
| error_slo_filter_override                         | ""                                       | No       |                                                                                                      |
| error_slo_warning                                 | None                                     | No       |                                                                                                      |
| error_slo_critical                                | 99.9                                     | No       |                                                                                                      |
| error_slo_alerting_enabled                        | True                                     | No       |                                                                                                      |
| error_slo_error_filter                            | ,!status:error                           | No       | Filter string to select the non-errors for the SLO, Dont forget to include the comma or (AND or OR) keywords |
| error_slo_timeframe                               | 30d                                      | No       |                                                                                                      |
| error_slo_numerator_override                      | ""                                       | No       |                                                                                                      |
| error_slo_denominator_override                    | ""                                       | No       |                                                                                                      |
| error_slo_burn_rate_notification_channel_override | ""                                       | No       |                                                                                                      |
| error_slo_burn_rate_enabled                       | True                                     | No       |                                                                                                      |
| error_slo_burn_rate_alerting_enabled              | True                                     | No       |                                                                                                      |
| error_slo_burn_rate_priority                      | 3                                        | No       | Number from 1 (high) to 5 (low).                                                                     |
| error_slo_burn_rate_warning                       | None                                     | No       |                                                                                                      |
| error_slo_burn_rate_critical                      | 10                                       | No       |                                                                                                      |
| error_slo_burn_rate_note                          | ""                                       | No       |                                                                                                      |
| error_slo_burn_rate_docs                          | Use burn rates alerts to measure how fast your error budget is being depleted relative to the time window of your SLO. For example, for a 30 day SLO if a burn rate of 1 is sustained, that means the error budget will be fully depleted in exactly 30 days, a burn rate of 2 means in exactly 15 days, etc. Therefore, you could use a burn rate alert to notify you if a burn rate of 10 is measured in the past hour. Burn rate alerts evaluate two time windows: a long window which you specify and a short window that is automatically calculated as 1/12 of your long window. The long window's purpose is to reduce alert flappiness, while the short window's purpose is to improve recovery time. If your threshold is violated in both windows, you will receive an alert. | No       |                                                                                                      |
| error_slo_burn_rate_evaluation_period             | 30d                                      | No       |                                                                                                      |
| error_slo_burn_rate_short_window                  | 5m                                       | No       |                                                                                                      |
| error_slo_burn_rate_long_window                   | 1h                                       | No       |                                                                                                      |


## Latency Slo

Use burn rates alerts to measure how fast your error budget is being depleted relative to the time window of your SLO. For example, for a 30 day SLO if a burn rate of 1 is sustained, that means the error budget will be fully depleted in exactly 30 days, a burn rate of 2 means in exactly 15 days, etc. Therefore, you could use a burn rate alert to notify you if a burn rate of 10 is measured in the past hour. Burn rate alerts evaluate two time windows: a long window which you specify and a short window that is automatically calculated as 1/12 of your long window. The long window's purpose is to reduce alert flappiness, while the short window's purpose is to improve recovery time. If your threshold is violated in both windows, you will receive an alert.

Query:
```terraform
burn_rate(\"${local.latency_slo_id}\").over(\"${var.latency_slo_burn_rate_evaluation_period}\").long_window(\"${var.latency_slo_burn_rate_long_window}\").short_window(\"${var.latency_slo_burn_rate_short_window}\") > ${var.latency_slo_burn_rate_critical}
```

| variable                                            | default                                  | required | description                                                                                          |
|-----------------------------------------------------|------------------------------------------|----------|------------------------------------------------------------------------------------------------------|
| latency_slo_enabled                                 | True                                     | No       | Note that this monitor requires custom metrics to be present. Those can unfortunately not be created with Terraform yet |
| latency_slo_note                                    | ""                                       | No       |                                                                                                      |
| latency_slo_docs                                    | ""                                       | No       |                                                                                                      |
| latency_slo_filter_override                         | ""                                       | No       |                                                                                                      |
| latency_slo_warning                                 | None                                     | No       |                                                                                                      |
| latency_slo_critical                                | 99.9                                     | No       |                                                                                                      |
| latency_slo_latency_bucket                          |                                          | Yes      | SLO latency bucket in ms for your logs                                                               |
| latency_slo_alerting_enabled                        | True                                     | No       |                                                                                                      |
| latency_slo_timeframe                               | 30d                                      | No       |                                                                                                      |
| latency_slo_burn_rate_priority                      | 3                                        | No       | Number from 1 (high) to 5 (low).                                                                     |
| latency_slo_burn_rate_warning                       | None                                     | No       |                                                                                                      |
| latency_slo_burn_rate_critical                      | 10                                       | No       |                                                                                                      |
| latency_slo_burn_rate_note                          | ""                                       | No       |                                                                                                      |
| latency_slo_burn_rate_docs                          | Use burn rates alerts to measure how fast your error budget is being depleted relative to the time window of your SLO. For example, for a 30 day SLO if a burn rate of 1 is sustained, that means the error budget will be fully depleted in exactly 30 days, a burn rate of 2 means in exactly 15 days, etc. Therefore, you could use a burn rate alert to notify you if a burn rate of 10 is measured in the past hour. Burn rate alerts evaluate two time windows: a long window which you specify and a short window that is automatically calculated as 1/12 of your long window. The long window's purpose is to reduce alert flappiness, while the short window's purpose is to improve recovery time. If your threshold is violated in both windows, you will receive an alert. | No       |                                                                                                      |
| latency_slo_burn_rate_evaluation_period             | 30d                                      | No       |                                                                                                      |
| latency_slo_burn_rate_short_window                  | 5m                                       | No       |                                                                                                      |
| latency_slo_burn_rate_long_window                   | 1h                                       | No       |                                                                                                      |
| latency_slo_burn_rate_notification_channel_override | ""                                       | No       |                                                                                                      |
| latency_slo_burn_rate_enabled                       | True                                     | No       |                                                                                                      |
| latency_slo_burn_rate_alerting_enabled              | True                                     | No       |                                                                                                      |
| latency_slo_custom_numerator                        | ""                                       | No       |                                                                                                      |
| latency_slo_custom_denominator                      | ""                                       | No       |                                                                                                      |


## Slo Metrics

| variable                           | default                                  | required | description           |
|------------------------------------|------------------------------------------|----------|-----------------------|
| generate_metrics_based_on_logs     | True                                     | No       |                       |
| duration_group_bys_override        | None                                     | No       |                       |
| request_count_group_bys_override   | None                                     | No       |                       |
| latency_buckets_group_bys_override | None                                     | No       |                       |
| latency_buckets                    | [100, 250, 500, 1000, 2500, 5000, 10000] | No       | Latency buckets in ms |


## Module Variables

| variable                | default  | required | description                                                                                          |
|-------------------------|----------|----------|------------------------------------------------------------------------------------------------------|
| env                     |          | Yes      |                                                                                                      |
| service                 | ""       | No       |                                                                                                      |
| service_display_name    | None     | No       |                                                                                                      |
| notification_channel    |          | Yes      |                                                                                                      |
| additional_tags         | []       | No       |                                                                                                      |
| locked                  | True     | No       |                                                                                                      |
| name_prefix             | ""       | No       |                                                                                                      |
| name_suffix             | ""       | No       |                                                                                                      |
| create_metrics          | True     | No       |                                                                                                      |
| slo_filter_str_override | None     | No       | Override for the SLO filter string                                                                   |
| slo_metric_prefix       |          | Yes      | The prefix to use for the computed metrics. Example: apache. if logs are coming from apache          |
| log_source_name         |          | Yes      | The name of the system sending these access logs (eg. Apache, Nginx...)                              |
| logs_filter_query       |          | Yes      | The logs query to filter for portion of access logs that we which to compute SLO's for. We advise to use the source tag for this (eg. source:apache) |
| logs_service_identifier | service  | No       |                                                                                                      |


