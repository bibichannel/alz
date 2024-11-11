## Connectivity 
output "dine_azure_monitor_baseline_alerts_for_connectivity_01" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_connectivity_01
}

output "dine_azure_monitor_baseline_alerts_for_connectivity_02" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_connectivity_02
}

## decommissioned
output "deny_dine_alz_decommissioned" {
  value = module.definitions.deny_dine_alz_decommissioned
}

## identity
output "dine_azure_monitor_baseline_alerts_for_identity" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_identity
}

## intermediate_root
output "dine_microsoft_defender_for_cloud_configuration" {
  value = module.definitions.dine_microsoft_defender_for_cloud_configuration
}

output "dine_azure_compute_security_benchmark_compliance" {
  value = module.definitions.dine_azure_compute_security_benchmark_compliance
}

output "audit_unused_resources_cost_optimization" {
  value = module.definitions.audit_unused_resources_cost_optimization
}

output "dine_azure_monitor_baseline_alerts_for_service_health" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_service_health
}

output "audit_virtual_machines_for_trusted_launch_support" {
  value = module.definitions.audit_virtual_machines_for_trusted_launch_support
}

output "audit_resource_skus" {
  value = module.definitions.audit_resource_skus
}

## landingzones
output "deny_dine_append_tls_ssl" {
  value = module.definitions.deny_dine_append_tls_ssl
}

output "dine_azure_monitor_baseline_alerts_for_landing_zone_01" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_landing_zone_01
}

output "dine_azure_monitor_baseline_alerts_for_landing_zone_02" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_landing_zone_02
}

## management
output "dine_azure_monitor_baseline_alerts_for_management" {
  value = module.definitions.dine_azure_monitor_baseline_alerts_for_management
}

## sandbox
output "deny_alz_sandbox" {
  value = module.definitions.deny_alz_sandbox
}

## security
output "audit_resources_without_encryption_with_cmk" {
  value = module.definitions.audit_resources_without_encryption_with_cmk
}

## shared_services
output "audit_guardrails_for_azure_Key_Vault" {
  value = module.definitions.audit_guardrails_for_azure_Key_Vault
}

output "audit_backup_and_recovery" {
  value = module.definitions.audit_backup_and_recovery
}

output "modify_aum_check_updates" {
  value = module.definitions.modify_aum_check_updates
}

output "audit_public_paas_endpoints" {
  value = module.definitions.audit_public_paas_endpoints
}

output "dine_private_dns_zones" {
  value = module.definitions.dine_private_dns_zones
}

output "audit_denyaction_log_analytics_workspace" {
  value = module.definitions.audit_denyaction_log_analytics_workspace
}

output "audit_deny_tag_for_resources" {
  value = module.definitions.audit_deny_tag_for_resources
}

output "deny_sources_without_trusted_image" {
  value = module.definitions.deny_sources_without_trusted_image
}

output "enforce_tag_specification" {
  value = module.definitions.enforce_tag_specification
}