# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-MDFC-Config_20240319.html
# locals {
#   dine_mdfc_config_policy_ids = {
#     "vulnerability_assessment_provider"    = "13ce0167-8ca6-4048-8e6b-f996402e3c1b",
#     "defender_key_vault"                   = "1f725891-01c0-420a-9059-4fa46cb770b7",
#     "defender_open_source_databases"       = "44433aa3-7ec2-4002-93ea-65c65ff0310a",
#     "defender_sql_servers"                 = "50ea7265-7d8c-429e-9a7d-ca1f410191c3",
#     "defender_aks_clusters"                = "64def556-fbad-4622-930e-72d1d5589bf5",
#     "defender_cspm"                        = "72f8cee7-2937-403d-84a1-a4e3e57f3c21",
#     "alternative_vulnerability_assessment" = "766e621d-ba95-4e43-a6f2-e945db3d7888",
#     "defender_cosmos_db"                   = "82bf5b87-728b-4a74-ba4d-6123845cf542",
#     "defender_servers"                     = "8e86a5b6-b9bd-49d1-8e21-4bb8a0862222",
#     "policy_addon_aks"                     = "a8eff44f-8c92-45c3-a3fb-9880802d67a7",
#     "defender_app_service"                 = "b40e7bcd-a1e5-47fe-b9cf-2f534d0bfb7d",
#     "defender_resource_manager"            = "b7021b2b-08fd-4dc0-9de7-3c6ece09faf9",
#     "defender_sql_database"                = "b99b73e7-074b-4089-9395-b7236f094491",
#     "defender_containers"                  = "c9ddb292-b203-4738-aead-18e2716e858f",
#     "defender_storage"                     = "cfdc5972-75b3-4418-8ae1-7f5c36839390",
#     "defender_log_analytics_export"        = "ffb6f416-7bd2-4488-8828-56585fef2be9"
#   }
# }

# data "azurerm_policy_definition" "dine_mdfc_config_policy_definitions" {
#   for_each = local.dine_mdfc_config_policy_ids
#   name     = each.value
# }

# module "dine_mdfc_config_custom_policy_definitions" {
#   source              = "..//modules/definition"
#   for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "dine_mdfc_config*.json"))
#   file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
#   management_group_id = var.intermediate_root_management_group_id
# }

# module "dine_microsoft_defender_for_cloud_configuration" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "dine_mdfc_config"
#   initiative_display_name = "Deploy Microsoft Defender for Cloud Configuration"
#   initiative_description  = "Deploy Microsoft Defender for Cloud Configuration"
#   initiative_category     = "Security Center"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = concat(
#     [for definition in data.azurerm_policy_definition.dine_mdfc_config_policy_definitions : definition],
#     [for policy in module.dine_mdfc_config_custom_policy_definitions : policy.definition]
#   )
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-ACSB.html
# locals {
#   dine_acsb_policy_ids = {
#     "guest_configuration_vm_system_assigned_identity" = "3cf2ab00-13f1-4d0c-8971-2ac904541a7e",
#     "linux_guest_configuration_extension"             = "331e8ea8-378a-410f-a2e5-ae22f38bb0da",
#     "windows_guest_configuration_extension"           = "385f5831-96d4-41db-9a3c-cd3af78aaae6",
#     "linux_security_baseline_requirements"            = "fc9b3da7-8347-4380-8e70-0a0361d8dedd",
#     "windows_security_baseline_requirements"          = "72650e9f-97bc-4b2a-ab5f-9781a9fcecbc"
#   }
# }

# data "azurerm_policy_definition" "dine_acsb_policy_definitions" {
#   for_each = local.dine_acsb_policy_ids
#   name     = each.value
# }

# module "dine_azure_compute_security_benchmark_compliance" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "dine_acsb"
#   initiative_display_name = "Enforce Azure Compute Security Benchmark compliance auditing"
#   initiative_description  = "Enforce Azure Compute Security Benchmark compliance auditing for Windows and Linux virtual machines."
#   initiative_category     = "Guest Configuration"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.dine_acsb_policy_definitions : definition
#   ]
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Audit-UnusedResourcesCostOptimization.html
# module "audit_unused_resources_policy_definitions" {
#   source              = "..//modules/definition"
#   for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "audit_unused_resources*.json"))
#   file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
#   management_group_id = var.intermediate_root_management_group_id
# }

# module "audit_unused_resources_cost_optimization" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "audit_unused_resources"
#   initiative_display_name = "Unused resources driving cost should be avoided"
#   initiative_description  = "Optimize cost by detecting unused but chargeable resources. Leverage this Azure Policy Initiative as a cost control tool to reveal orphaned resources that are contributing cost."
#   initiative_category     = "Cost Optimization"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for policy in module.audit_unused_resources_policy_definitions : policy.definition
#   ]
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Alerting-ServiceHealth.html
# module "dine_service_health_policy_definitions" {
#   source              = "..//modules/definition"
#   for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "dine_service_health*.json"))
#   file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
#   management_group_id = var.intermediate_root_management_group_id
# }

# module "dine_azure_monitor_baseline_alerts_for_service_health" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "dine_service_health"
#   initiative_display_name = "Deploy Azure Monitor Baseline Alerts for Service Health"
#   initiative_description  = "This initiative deploys Azure Monitor Baseline Alerts to monitor Service Health Events such as Service issues, Planned maintenance, Health advisories, Security advisories, and Resource health."
#   initiative_category     = "Monitoring"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for policy in module.dine_service_health_policy_definitions : policy.definition
#   ]
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Audit-TrustedLaunch.html

# locals {
#   audit_trusted_launch_policy_ids = {
#     "disks_os_image_support_trusted_launch" = "b03bb370-5249-4ea4-9fce-2552e87e45fa",
#     "vm_should_have_trusted_launch_enabled" = "c95b54ad-0614-4633-ab29-104b01235cbf",
#   }
# }

# data "azurerm_policy_definition" "audit_trusted_launch_policy_definitions" {
#   for_each = local.audit_trusted_launch_policy_ids
#   name     = each.value
# }

# module "audit_virtual_machines_for_trusted_launch_support" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "audit_trusted_launch"
#   initiative_display_name = "Audit virtual machines for Trusted Launch support"
#   initiative_description  = "Trusted Launch improves security of a Virtual Machine which requires VM SKU, OS Disk & OS Image to support it (Gen 2)."
#   initiative_category     = "Trusted Launch"
#   management_group_id     = var.intermediate_root_management_group_id
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.audit_trusted_launch_policy_definitions : definition
#   ]
# }

# # Custom
# module "audit_resource_skus_policy_definitions" {
#   source              = "..//modules/definition"
#   for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "audit_resource_skus*.json"))
#   file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
#   management_group_id = var.intermediate_root_management_group_id
# }

# module "audit_resource_skus" {
#   source = "../modules/initiative"
#   initiative_name         = "audit_resource_skus"
#   initiative_display_name = "Allowed Resource SKUs"
#   initiative_description  = "Allowed Resource SKUs"
#   initiative_category     = "Tag Governance"
#   management_group_id     = var.intermediate_root_management_group_id
#   member_definitions = [
#     for policy in module.audit_resource_skus_policy_definitions : policy.definition
#   ]
# }

# module "enforce_tag_governance_for_resources" {
#   source = "..//modules/initiative"
#   initiative_name         = "tag_governance_for_inherit"
#   initiative_display_name = "Tag Governance for Inherit"
#   initiative_description  = "Tag Governance for Inherit"
#   initiative_category     = "Tag Governance"
#   management_group_id     = var.intermediate_root_management_group_id
#   member_definitions = [

#   ]
# }

# module "ensure_log_analytics_workspace_compliance_and_protection" {
#   source = "../modules/initiative"
#   initiative_name         = "ensure_log_analytics_workspace_compliance_and_protection"
#   initiative_display_name = "Ensure Log Analytics Workspace compliance and protection"
#   initiative_description  = "Ensure Log Analytics Workspace compliance and protection"
#   initiative_category     = "Tag Governance"
#   management_group_id     = var.intermediate_root_management_group_id
#   member_definitions = [

#   ]
# }
