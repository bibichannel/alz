# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Alerting-Management.html
module "dine_alert_management_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/management/", "dine_alert_management*.json"))
  file_path           = "${path.module}/../custom_policy/management/${each.value}"
  management_group_id = var.management_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_management" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_management"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Management"
  initiative_description  = "Initiative to deploy AMBA alerts relevant to the ALZ Management management group"
  initiative_category     = "Monitoring"
  management_group_id     = var.management_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_management_custom_policy_definitions : policy.definition
  ]

}