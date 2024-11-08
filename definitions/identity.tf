# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Alerting-Identity.html
module "dine_alert_identity_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/identity/", "dine_alert_identity*.json"))
  file_path           = "${path.module}/../custom_policy/identity/${each.value}"
  management_group_id = var.identity_management_group_id
}

module "dine_azure_monitor_baseline_alerts_for_identity" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_alert_identity"
  initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Identity"
  initiative_description  = "Initiative to deploy AMBA alerts relevant to the ALZ Identity management group"
  initiative_category     = "Monitoring"
  management_group_id     = var.identity_management_group_id
  initiative_version      = "1.0.0"
  member_definitions = [
    for policy in module.dine_alert_identity_custom_policy_definitions : policy.definition
  ]

}
