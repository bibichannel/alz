## Connectivity 
output "dine_azure_monitor_baseline_alerts_for_connectivity_01" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_connectivity_01.parameters)
}

output "dine_azure_monitor_baseline_alerts_for_connectivity_02" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_connectivity_02.parameters)
}

## decommissioned
output "deny_dine_alz_decommissioned" {
  value = keys(module.deny_dine_alz_decommissioned.parameters)
}

## identity
output "dine_azure_monitor_baseline_alerts_for_identity" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_identity.parameters)
}

## intermediate_root
output "dine_microsoft_defender_for_cloud_configuration" {
  value = keys(module.dine_microsoft_defender_for_cloud_configuration.parameters)
}

output "dine_azure_compute_security_benchmark_compliance" {
  value = keys(module.dine_azure_compute_security_benchmark_compliance.parameters)
}

output "audit_unused_resources_cost_optimization" {
  value = keys(module.audit_unused_resources_cost_optimization.parameters)
}

output "dine_azure_monitor_baseline_alerts_for_service_health" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_service_health.parameters)
}

output "audit_virtual_machines_for_trusted_launch_support" {
  value = keys(module.audit_virtual_machines_for_trusted_launch_support.parameters)
}

output "audit_resource_skus" {
  value = keys(module.audit_resource_skus.parameters)
}

## landingzones
output "deny_dine_append_tls_ssl" {
  value = keys(module.deny_dine_append_tls_ssl.parameters)
}

output "dine_azure_monitor_baseline_alerts_for_landing_zone_01" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_landing_zone_01.parameters)
}

output "dine_azure_monitor_baseline_alerts_for_landing_zone_02" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_landing_zone_02.parameters)
}

## management
output "dine_azure_monitor_baseline_alerts_for_management" {
  value = keys(module.dine_azure_monitor_baseline_alerts_for_management.parameters)
}

## sandbox
output "deny_alz_sandbox" {
  value = keys(module.deny_alz_sandbox.parameters)
}

## security
output "audit_resources_without_encryption_with_cmk" {
  value = keys(module.audit_resources_without_encryption_with_cmk.parameters)
}

## shared_services
output "audit_guardrails_for_azure_Key_Vault" {
  value = keys(module.audit_guardrails_for_azure_Key_Vault.parameters)
}

output "audit_backup_and_recovery" {
  value = keys(module.audit_backup_and_recovery.parameters)
}

output "modify_aum_check_updates" {
  value = keys(module.modify_aum_check_updates.parameters)
}

output "audit_public_paas_endpoints" {
  value = keys(module.audit_public_paas_endpoints.parameters)
}

output "dine_private_dns_zones" {
  value = keys(module.dine_private_dns_zones.parameters)
}