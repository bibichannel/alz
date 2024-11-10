# Limitations
- DefinitionName and InitiativeName have a maximum length of 64 characters
- AssignmentName has maximum length of 24 characters at Management Group Scope and 64 characters at all other Scopes
- DisplayName has a maximum length of 128 characters and description a maximum length of 512 characters

# Naming convention
- Initiative name: `<default_action>_<generic_services_name>`
- Custom policy definition file name: `<initiative_name>_<definition_name>.json`

Example:
```
# Initiative name
audit_unused_resources

# Custom policy definition file name
- audit_unused_resources_azure_hybrid_benefit
- audit_unused_resources_disks
- audit_unused_resources_public_ip_addresses
- audit_unused_resources_server_farms
```
Benefit: for_each quickly read all file relevent to regarding intiative.


## Intermediate root
### Definition sets built-in
```
e20d08c5-6d64-656d-6465-ce9e37fd0ebc    dine_microsoft_defender_for_endpoint_agent
77b391e3-2d5d-40c3-83bf-65c846b3c6a3    dine_defender_endpoint_integration_with_defender_cloud
0884adba-2312-4468-abeb-5422caed1038    dine_diagnostic_settings_to_azure_services
1f3afdf9-d0c9-4c3d-847f-89da613e70a8    audit_microsoft_cloud_security_benchmark
e77fc0b3-f7e9-4c58-bc13-cb753ed8e46e    dine_advanced_threat_protection_on_open_source_dbs
9cb3cc7a-b39b-4b82-bc89-e5a5d9ff7b97    dine_azure_defender_on_sql_servers_and_managed_instances
130fb88f-0fc9-4678-bfe1-31022d71c7d5    audit_resources_should_be_zone_resilient
06f19060-9e68-4070-92ca-f15cc126059e    manual_cis_microsoft_azure_foundations_benchmark_v2_0_0
89c6cddc-1c73-4ac1-b19c-54d1a15a42f2    manual_iso_27001_2013
```

### Definition sets custom 
```
dine_mdfc_config                        dine_microsoft_defender_for_cloud_configuration
dine_acsb                               dine_azure_compute_security_benchmark_compliance
audit_unused_resources                  audit_unused_resources_cost_optimization
dine_service_health                     dine_azure_monitor_baseline_alerts_for_service_health
audit_trusted_launch                    audit_virtual_machines_for_trusted_launch_support
audit_resource_skus                     audit_resource_skus
                                        audit_deny_tag_for_resources
                                        audit_denyaction_log_analytics_workspace
```

### Definitions built-in
```
2465583e-4e78-4c15-b6be-a36cbc7c8b0f    dine_activity_logs_to_stream_to_log_analytics_workspace
6c112d4e-5bc7-47ae-a041-ea2d9dccd749    deny_deployment_of_classic_resources
06a78e20-9358-41c9-923c-fb736d382a4d    audit_vms_that_do_not_use_managed_disks
0a914e76-4921-4c19-b460-a2d36003525a    audit_resource_location_matches_resource_group_location
```

---

## Landing zones
### Definition sets built-in
```
924bfe3a-762f-40e7-86dd-5c8b95eb09e6	dine_vm_monitoring
f5bf694c-cca7-4033-b883-3a23327d5485	dine_vmss_monitoring
2b00397d-c309-49c4-aa5a-f0b2c5bc6321	dine_vm_hybrid_monitoring
92a36f05-ebc9-4bba-9128-b47ad2ea3354	dine_change_tracking_and_inventory_vm
c4a70814-96be-461c-889f-2b27429120dc	dine_change_tracking_and_inventory_vmss
53448c70-089b-4f52-8f38-89196d7f2de1	dine_change_tracking_and_inventory_vm_arc
de01d381-bae9-4670-8870-786f89f49e26	dine_mdfc_defender_sql_and_ama
```

### Definition sets custom
```
deny_dine_append_tls_ssl                deny_dine_append_tls_ssl
audit_guardrails_az_kv                  audit_guardrails_for_azure_Key_Vault
audit_backup_and_recovery               audit_backup_and_recovery
dine_alert_lz_01                        dine_azure_monitor_baseline_alerts_for_landing_zone_01
dine_alert_lz_02                        dine_azure_monitor_baseline_alerts_for_landing_zone_02
modify_aum_check_updates                modify_aum_check_updates
```

### Definitions built-in
```
88c0b9da-ce96-4b03-9635-f29a937e2900	deny_ip_forwarding_network_interface
404c3081-a854-4457-ae30-26a93ef643f9	audit_storage_without_https
a8eff44f-8c92-45c3-a3fb-9880802d67a7	dine_aks_policy_addon
25da7dfb-0666-4a15-a8f5-402127efd8bb	dine_sql_auditing
36d49e87-48c4-4f2e-beed-ba4ed02b71f5	dine_sql_threat
86a912f6-9a06-4e26-b447-11b16ba8659f	dine_sql_encryption
94de2ad3-e0c1-4caf-ad78-5d47bbc83d3d	modify_ddos
95edb821-ddaf-4404-9732-666045e056b4	deny_aks_privileged
1c6e92c9-99f0-4e55-9cf2-0c234dc48f99	audit_aks_priv_escalation
1a5b4dca-0b6f-4cf5-907c-56316bc1bf3d	deny_aks_without_https
564feb30-bf6a-4854-b4bb-0d2d2d1e6c66	audit_app_gw_waf
98d0b9f8-fd90-49c9-88e2-d3baf3b0dd86	dine_vm_backup
7bca8353-aa3b-429b-904a-9229c4385837	audit_subnet_private
e56962a6-4747-49cd-b67b-bf8b01975c4c	deny_locations
```

### Definitions custom
```
deny_mgmt_ports_from_internet           deny_mgmt_ports_from_internet
deny_subnet_without_nsg                 deny_subnet_without_nsg
deny_create_resources_temporary
```

---

## Foundations
### Definition sets built-in```
924bfe3a-762f-40e7-86dd-5c8b95eb09e6	dine_vm_monitoring
f5bf694c-cca7-4033-b883-3a23327d5485	dine_vmss_monitoring
2b00397d-c309-49c4-aa5a-f0b2c5bc6321	dine_vm_hybrid_monitoring
92a36f05-ebc9-4bba-9128-b47ad2ea3354	dine_change_tracking_and_inventory_vm
c4a70814-96be-461c-889f-2b27429120dc	dine_change_tracking_and_inventory_vmss
53448c70-089b-4f52-8f38-89196d7f2de1	dine_change_tracking_and_inventory_vm_arc
de01d381-bae9-4670-8870-786f89f49e26	dine_mdfc_defender_sql_and_ama
```

### Definition sets custom
```
audit_guardrails_az_kv                  audit_guardrails_for_azure_Key_Vault
audit_backup_and_recovery               audit_backup_and_recovery
modify_aum_check_updates                modify_aum_check_updates
enforce_tag_specification               enforce_tag_specification
```

### Definitions built-in
```
7bca8353-aa3b-429b-904a-9229c4385837	audit_subnet_private
78460a36-508a-49a4-b2b2-2f5ec564f4bb	denyaction_resource_deletion
e56962a6-4747-49cd-b67b-bf8b01975c4c	deny_locations
```

### Definitions custom
```
deny_create_resources_temporary
```

**```
924bfe3a-762f-40e7-86dd-5c8b95eb09e6	dine_vm_monitoring
f5bf694c-cca7-4033-b883-3a23327d5485	dine_vmss_monitoring
2b00397d-c309-49c4-aa5a-f0b2c5bc6321	dine_vm_hybrid_monitoring
92a36f05-ebc9-4bba-9128-b47ad2ea3354	dine_change_tracking_and_inventory_vm
c4a70814-96be-461c-889f-2b27429120dc	dine_change_tracking_and_inventory_vmss
53448c70-089b-4f52-8f38-89196d7f2de1	dine_change_tracking_and_inventory_vm_arc
de01d381-bae9-4670-8870-786f89f49e26	dine_mdfc_defender_sql_and_ama
```

### Definition sets custom
```
audit_guardrails_az_kv                  audit_guardrails_for_azure_Key_Vault
audit_backup_and_recovery               audit_backup_and_recovery
modify_aum_check_updates                modify_aum_check_updates
enforce_tag_specification               enforce_tag_specification
```

### Definitions built-in
```
7bca8353-aa3b-429b-904a-9229c4385837	audit_subnet_private
78460a36-508a-49a4-b2b2-2f5ec564f4bb	denyaction_resource_deletion
e56962a6-4747-49cd-b67b-bf8b01975c4c	deny_locations
```

### Definitions custom
```
deny_create_resources_temporary
```
**
---

## Connectivity
### Definition sets custom
```
dine_alert_connectivity_01              dine_azure_monitor_baseline_alerts_for_connectivity_01
dine_alert_connectivity_01              dine_azure_monitor_baseline_alerts_for_connectivity_01
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
94de2ad3-e0c1-4caf-ad78-5d47bbc83d3d	modify_ddos
```

---

## Management
### Definition sets custom
```
dine_alert_management                   dine_azure_monitor_baseline_alerts_for_management
```

### Definitions built-in
```
8e3e61b3-0b32-22d5-4edf-55f87fdb5955	dine_log_analytic
```

---

## Identity
### Definition sets custom
```
dine_alert_identity                     dine_azure_monitor_baseline_alerts_for_identity
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
98d0b9f8-fd90-49c9-88e2-d3baf3b0dd86	dine_vm_backup
```

### Definitions custom
```
deny_public_ip                          deny_public_ip
deny_subnet_without_nsg                 deny_subnet_without_nsg
```

---

## Security
### Definition sets custom
```
audit_encryption_cmk                    audit_resources_without_encryption_with_cmk
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
78460a36-508a-49a4-b2b2-2f5ec564f4bb	denyaction_resource_deletion
```

---

## Shared services
### Definition sets custom
```
audit_public_paas_endpoints             audit_public_paas_endpoints
dine_private_dns_zones                  dine_private_dns_zones
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
e765b5de-1225-4ba3-bd56-1ac6695af988	deny_location_resource_groups
```

---

## IT
### Definition sets custom
```
audit_public_paas_endpoints             audit_public_paas_endpoints
dine_private_dns_zones                  dine_private_dns_zones
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
83a86a26-fd1f-447c-b59d-e51f44264114	deny_public_ip_address_on_nic
6c112d4e-5bc7-47ae-a041-ea2d9dccd749	deny_hybrid_networking
```

### Definitions custom
```
audit_private_link_dns_zones            audit_private_link_dns_zones 
```

---

## Internal
### Definition sets custom
```
audit_public_paas_endpoints             audit_public_paas_endpoints
dine_private_dns_zones                  dine_private_dns_zones
```

### Definitions built-in
```
83a86a26-fd1f-447c-b59d-e51f44264114	deny_public_ip_address_on_nic
6c112d4e-5bc7-47ae-a041-ea2d9dccd749	deny_hybrid_networking
```

### Definitions custom
```
audit_private_link_dns_zones            audit_private_link_dns_zones 
```

---

## External
### Definition sets custom
```
audit_public_paas_endpoints             audit_public_paas_endpoints
dine_private_dns_zones                  dine_private_dns_zones
deny_sources_without_trusted_image      deny_sources_without_trusted_image
```

### Definitions built-in
```
83a86a26-fd1f-447c-b59d-e51f44264114	deny_public_ip_address_on_nic
6c112d4e-5bc7-47ae-a041-ea2d9dccd749	deny_hybrid_networking
```

### Definitions custom
```
audit_private_link_dns_zones            audit_private_link_dns_zones 
```

---

## Legacy
### Definition sets custom
```
audit_public_paas_endpoints             audit_public_paas_endpoints
dine_private_dns_zones                  dine_private_dns_zones
```

### Definitions built-in
```
83a86a26-fd1f-447c-b59d-e51f44264114	deny_public_ip_address_on_nic
6c112d4e-5bc7-47ae-a041-ea2d9dccd749	deny_hybrid_networking
```

### Definitions custom
```
audit_private_link_dns_zones            audit_private_link_dns_zones 
deny_create_subscription                deny_create_subscription
```

---

## Decommissioned
### Definition sets custom
```
deny_dine_alz_decommissioned            deny_dine_alz_decommissioned
```

---

## Sandbox Zones
### Definition sets custom
```
deny_alz_sandbox                        deny_alz_sandbox
enforce_tag_specification               enforce_tag_specification
```

### Definitions built-in
```
6c112d4e-5bc7-47ae-a041-ea2d9dccd749	deny_hybrid_networking
e56962a6-4747-49cd-b67b-bf8b01975c4c	deny_locations
```

### Definitions custom
```
deny_public_ip                          deny_public_ip
deny_mgmt_ports_from_internet           deny_mgmt_ports_from_internet
125e78be-b7cd-4fa9-a269-729e6ef27d49    audit_nsg_rule_inbound_from_internet
deny_create_resources_temporary
```