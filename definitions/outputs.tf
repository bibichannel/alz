# # Intermediate root
# # Policy Set Definitions
# output "dine_microsoft_defender_for_endpoint_agent" {
#   value       = data.azurerm_policy_set_definition.dine_microsoft_defender_for_endpoint_agent
#   description = "This is the Policy Set Definition for deploying Microsoft Defender for Endpoint Agent"
# }

# output "dine_defender_endpoint_integration_with_defender_cloud" {
#   value       = data.azurerm_policy_set_definition.dine_defender_endpoint_integration_with_defender_cloud
#   description = "This is the Policy Set Definition for configuring Defender Endpoint integration with Defender Cloud"
# }

# output "dine_diagnostic_settings_to_azure_services" {
#   value       = data.azurerm_policy_set_definition.dine_diagnostic_settings_to_azure_services
#   description = "This is the Policy Set Definition for deploying diagnostic settings to Azure services"
# }

# output "audit_microsoft_cloud_security_benchmark" {
#   value       = data.azurerm_policy_set_definition.audit_microsoft_cloud_security_benchmark
#   description = "This is the Policy Set Definition for the Microsoft Cloud Security Benchmark"
# }

# output "dine_advanced_threat_protection_on_open_source_dbs" {
#   value       = data.azurerm_policy_set_definition.dine_advanced_threat_protection_on_open_source_dbs
#   description = "This is the Policy Set Definition for enabling advanced threat protection on open source databases"
# }

# output "dine_azure_defender_on_sql_servers_and_managed_instances" {
#   value       = data.azurerm_policy_set_definition.dine_azure_defender_on_sql_servers_and_managed_instances
#   description = "This is the Policy Set Definition for enabling Azure Defender on SQL servers and managed instances"
# }

# output "audit_resources_should_be_zone_resilient" {
#   value       = data.azurerm_policy_set_definition.audit_resources_should_be_zone_resilient
#   description = "This is the Policy Set Definition for ensuring resources are zone resilient"
# }

# output "manual_cis_microsoft_azure_foundations_benchmark_v2_0_0" {
#   value       = data.azurerm_policy_set_definition.manual_cis_microsoft_azure_foundations_benchmark_v2_0_0
#   description = "This is the Policy Set Definition for the CIS Microsoft Azure Foundations Benchmark v2.0.0"
# }

# output "manual_iso_27001_2013" {
#   value       = data.azurerm_policy_set_definition.manual_iso_27001_2013
#   description = "This is the Policy Set Definition for ISO 27001:2013 compliance"
# }

# output "dine_microsoft_defender_for_cloud_configuration" {
#   value       = module.dine_microsoft_defender_for_cloud_configuration.initiative
#   description = "This is the custom Policy Set Definition for deploying Microsoft Defender for Cloud Configuration"
# }

# output "dine_azure_compute_security_benchmark_compliance" {
#   value       = module.dine_azure_compute_security_benchmark_compliance.initiative
#   description = "This is the custom Policy Set Definition for enforcing Azure Compute Security Benchmark compliance auditing"
# }

# output "unused_resources_cost_optimization" {
#   value       = module.unused_resources_cost_optimization.initiative
#   description = "This is the custom Policy Set Definition for optimizing cost by detecting unused resources"
# }

# output "deploy_azure_monitor_baseline_alerts_for_service_health" {
#   value       = module.deploy_azure_monitor_baseline_alerts_for_service_health.initiative
#   description = "This is the custom Policy Set Definition for deploying Azure Monitor Baseline Alerts for Service Health"
# }

# output "audit_virtual_machines_for_trusted_launch_support" {
#   value       = module.audit_virtual_machines_for_trusted_launch_support.initiative
#   description = "This is the custom Policy Set Definition for auditing virtual machines for Trusted Launch support"
# }

# # output "tag_governance_for_inherit" {
# #   value = module.tag_governance_for_inherit.initiative
# #   description = "This is the custom Policy Set Definition for Tag Governance for Inherit"
# # }

# # output "allowed_resource_skus" {
# #   value = module.allowed_resource_skus.initiative
# #   description = "This is the custom Policy Set Definition for Allowed Resource SKUs"
# # }

# # output "ensure_log_analytics_workspace_compliance_and_protection" {
# #   value = module.ensure_log_analytics_workspace_compliance_and_protection.initiative
# #   description = "This is the custom Policy Set Definition for ensuring Log Analytics Workspace compliance and protection"
# # }

# # Policy Definitions
# output "dine_activity_logs_to_stream_to_log_analytics_workspace" {
#   value       = data.azurerm_policy_definition_built_in.dine_activity_logs_to_stream_to_log_analytics_workspace
#   description = "This is the built-in Policy Definition for configuring activity logs to stream to Log Analytics workspace"
# }

# output "deny_deployment_of_classic_resources" {
#   value       = data.azurerm_policy_definition_built_in.deny_deployment_of_classic_resources
#   description = "This is the built-in Policy Definition that denies the deployment of classic resources"
# }

# output "audit_vms_that_do_not_use_managed_disks" {
#   value       = data.azurerm_policy_definition_built_in.audit_vms_that_do_not_use_managed_disks
#   description = "This is the built-in Policy Definition for auditing VMs that do not use managed disks"
# }

# output "audit_resource_location_matches_resource_group_location" {
#   value       = data.azurerm_policy_definition_built_in.audit_resource_location_matches_resource_group_location
#   description = "This is the built-in Policy Definition for auditing resource location to match resource group location"
# }
