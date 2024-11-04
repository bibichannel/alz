# Variables for Policy Set Definitions
variable "dine_microsoft_defender_for_endpoint_agent" {
  description = "Policy Set Definition for deploying Microsoft Defender for Endpoint Agent"
  type        = any
}

variable "dine_defender_endpoint_integration_with_defender_cloud" {
  description = "Policy Set Definition for configuring Defender Endpoint integration with Defender Cloud"
  type        = any
}

variable "dine_diagnostic_settings_to_azure_services" {
  description = "Policy Set Definition for deploying diagnostic settings to Azure services"
  type        = any
}

variable "audit_microsoft_cloud_security_benchmark" {
  description = "Policy Set Definition for the Microsoft Cloud Security Benchmark"
  type        = any
}

variable "dine_advanced_threat_protection_on_open_source_dbs" {
  description = "Policy Set Definition for enabling advanced threat protection on open source databases"
  type        = any
}

variable "dine_azure_defender_on_sql_servers_and_managed_instances" {
  description = "Policy Set Definition for enabling Azure Defender on SQL servers and managed instances"
  type        = any
}

variable "audit_resources_should_be_zone_resilient" {
  description = "Policy Set Definition for ensuring resources are zone resilient"
  type        = any
}

variable "manual_cis_microsoft_azure_foundations_benchmark_v2_0_0" {
  description = "Policy Set Definition for the CIS Microsoft Azure Foundations Benchmark v2.0.0"
  type        = any
}

variable "manual_iso_27001_2013" {
  description = "Policy Set Definition for ISO 27001:2013 compliance"
  type        = any
}

variable "dine_microsoft_defender_for_cloud_configuration" {
  description = "Custom Policy Set Definition for deploying Microsoft Defender for Cloud Configuration"
  type        = any
}

variable "dine_azure_compute_security_benchmark_compliance" {
  description = "Custom Policy Set Definition for enforcing Azure Compute Security Benchmark compliance auditing"
  type        = any
}

variable "unused_resources_cost_optimization" {
  description = "Custom Policy Set Definition for optimizing cost by detecting unused resources"
  type        = any
}

variable "deploy_azure_monitor_baseline_alerts_for_service_health" {
  description = "Custom Policy Set Definition for deploying Azure Monitor Baseline Alerts for Service Health"
  type        = any
}

variable "audit_virtual_machines_for_trusted_launch_support" {
  description = "Custom Policy Set Definition for auditing virtual machines for Trusted Launch support"
  type        = any
}

variable "tag_governance_for_inherit" {
  description = "Custom Policy Set Definition for Tag Governance for Inherit"
  type        = any
}

variable "allowed_resource_skus" {
  description = "Custom Policy Set Definition for Allowed Resource SKUs"
  type        = any
}

variable "ensure_log_analytics_workspace_compliance_and_protection" {
  description = "Custom Policy Set Definition for ensuring Log Analytics Workspace compliance and protection"
  type        = any
}

# Variables for Policy Definitions
variable "dine_activity_logs_to_stream_to_log_analytics_workspace" {
  description = "Built-in Policy Definition for configuring activity logs to stream to Log Analytics workspace"
  type        = any
}

variable "deny_deployment_of_classic_resources" {
  description = "Built-in Policy Definition that denies the deployment of classic resources"
  type        = any
}

variable "audit_vms_that_do_not_use_managed_disks" {
  description = "Built-in Policy Definition for auditing VMs that do not use managed disks"
  type        = any
}

variable "audit_resource_location_matches_resource_group_location" {
  description = "Built-in Policy Definition for auditing resource location to match resource group location"
  type        = any
}
