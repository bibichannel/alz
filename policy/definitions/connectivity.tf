# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Alerting-Connectivity.html
module "dine_alert_connectivity_01_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/connectivity/", "dine_alert_connectivity_01*.json"))
  file_path           = "${path.module}/../custom_policy/connectivity/${each.value}"
  management_group_id = var.connectivity_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_connectivity_01" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_connectivity_01"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Connectivity part 1"
  initiative_description  = "This initiative deploys Azure Monitor Baseline Alerts to monitor Network components such as Azure Firewalls, ExpressRoute, VPN, and Private DNS Zones."
  initiative_category     = "Monitoring"
  management_group_id     = var.connectivity_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_connectivity_01_custom_policy_definitions : policy.definition
  ]

}

module "dine_alert_connectivity_02_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/connectivity/", "dine_alert_connectivity_02*.json"))
  file_path           = "${path.module}/../custom_policy/connectivity/${each.value}"
  management_group_id = var.connectivity_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_connectivity_02" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_connectivity_02"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Connectivity part 2"
  initiative_description  = "This initiative deploys Azure Monitor Baseline Alerts to monitor Network components such as Azure Firewalls, ExpressRoute, VPN, and Private DNS Zones."
  initiative_category     = "Monitoring"
  management_group_id     = var.connectivity_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_connectivity_02_custom_policy_definitions : policy.definition
  ]

}