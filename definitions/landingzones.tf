# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-EncryptTransit.html
locals {
  deny_dine_append_tls_ssl_policy_ids = {
    "app_service_latest_tls"         = "f0e6e85b-9b9f-4a4b-b67b-f730d42f1b0b",
    "container_apps_https_only"      = "0e80e269-43a4-4ae9-b5bc-178126b8a5cb",
    "function_apps_latest_tls"       = "f9d614c5-c173-4d56-95a7-b4437057d193",
    "kubernetes_clusters_https_only" = "1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d",
    "audit_storage_min_tls"          = "fe83a0eb-a853-422d-aac2-1bffd182c5d0",
  }
}

data "azurerm_policy_definition" "deny_dine_append_tls_ssl_policy_definitions" {
  for_each = local.deny_dine_append_tls_ssl_policy_ids
  name     = each.value
}

module "deny_dine_append_tls_ssl_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/landing_zones/", "deny_dine_append_tls_ssl*.json"))
  file_path           = "${path.module}/../custom_policy/landing_zones/${each.value}"
  management_group_id = var.landing_zones_management_group_id
}

module "deny_dine_append_tls_ssl" {
  source                  = "..//modules/initiative"
  initiative_name         = "deny_dine_append_tls_ssl"
  initiative_display_name = "Enforce enhanced recovery and backup policies"
  initiative_description  = "Enforce enhanced recovery and backup policies on assigned scopes."
  initiative_category     = "Backup"
  management_group_id     = var.landing_zones_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for definition in data.azurerm_policy_definition.deny_dine_append_tls_ssl_policy_definitions : definition],
    [for policy in module.deny_dine_append_tls_ssl_custom_policy_definitions : policy.definition]
  )
}

# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Alerting-LandingZone.html
module "dine_alert_lz_01_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/landing_zones/", "dine_alert_lz_01*.json"))
  file_path           = "${path.module}/../custom_policy/landing_zones/${each.value}"
  management_group_id = var.landing_zones_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_landing_zone_01" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_lz_01"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Landing Zone part 1"
  initiative_description  = "Initiative to deploy AMBA alerts relevant to the ALZ LandingZone management group"
  initiative_category     = "Monitoring"
  management_group_id     = var.landing_zones_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_lz_01_custom_policy_definitions : policy.definition
  ]

}

module "dine_alert_lz_02_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/landing_zones/", "dine_alert_lz_02*.json"))
  file_path           = "${path.module}/../custom_policy/landing_zones/${each.value}"
  management_group_id = var.landing_zones_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_landing_zone_02" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_lz_02"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Landing Zone part 2"
  initiative_description  = "Initiative to deploy AMBA alerts relevant to the ALZ LandingZone management group"
  initiative_category     = "Monitoring"
  management_group_id     = var.landing_zones_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_lz_02_custom_policy_definitions : policy.definition
  ]

}