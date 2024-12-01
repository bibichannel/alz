# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-KeyVault.html
locals {
  audit_guardrails_az_kv_policy_ids = {
    "key_vault_managed_hsm_keys_expiration"             = "1d478a74-21ba-4b9f-9d8f-8e6fced0eec5",
    "key_vault_managed_hsm_keys_days_before_expiration" = "ad27588c-0198-4c84-81ef-08efd0274653",
    "key_vault_managed_hsm_keys_curve_names"            = "e58fd0c1-feac-4d12-92db-0a7e9421f53e",
    "key_vault_managed_hsm_keys_min_rsa_size"           = "86810a98-8e91-4a44-8386-ec66d0de5d57",
    "key_vault_managed_hsm_purge_protection"            = "c39ba22d-4428-4149-b981-70acb31fc383",
    "key_vault_firewall_enabled"                        = "55615ac9-af46-4a59-874e-391cc3dfb490",
    "key_vault_rbac_permission_model"                   = "12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5",
    "certificates_integrated_issuer"                    = "8e826246-c976-48f6-b03e-619bb92b3d82",
    "certificates_non_integrated_issuer"                = "a22f4a40-01d3-4c7d-8071-da157eeff341",
    "certificates_lifetime_action_triggers"             = "12ef42cb-9903-4e39-9c26-422d29570417",
    "certificates_max_validity_period"                  = "0a075868-4c26-42ef-914c-5bc007359560",
    "certificates_days_until_expiration"                = "f772fb64-8e40-40ad-87bc-7706e1949427",
    "certificates_allowed_key_types"                    = "1151cede-290b-4ba0-8b38-0ad145ac888f",
    "certificates_curve_names_ec"                       = "bd78111f-4953-4367-9fd5-7e08808b54bf",
    "certificates_min_rsa_key_size"                     = "cee51871-e572-4576-855c-047c820360f0",
    "key_vault_keys_expiration"                         = "152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0",
    "key_vault_secrets_expiration"                      = "98728c90-32c7-4049-8429-847dc0f4fe37",
    "key_vault_deletion_protection"                     = "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53",
    "key_vault_soft_delete"                             = "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d",
    "keys_cryptographic_type"                           = "75c4f823-d65c-4f29-a733-01d0077fdbcb",
    "keys_days_before_expiration"                       = "5ff38825-c5d8-47c5-b70e-069a21955146",
    "keys_max_validity_period"                          = "49a22571-d204-4c91-a7b6-09b1a586fbc9",
    "keys_max_active_duration"                          = "c26e4b24-cf98-4c67-b48b-5a25c4c69eb9",
    "keys_curve_names_ec"                               = "ff25f3c8-b739-4538-9d07-3d6d25cfb255",
    "keys_min_rsa_key_size"                             = "82067dbb-e53b-4e06-b631-546d197452d9",
    "secrets_content_type_set"                          = "75262d3e-ba4a-4f43-85f8-9f72c090e5e3",
    "secrets_days_before_expiration"                    = "b0eb591a-5e70-4534-a8bf-04b9c489584a",
    "secrets_max_validity_period"                       = "342e8053-e12e-4c44-be01-c3c2f318400f",
    "secrets_max_active_duration"                       = "e8d99835-8a06-45ae-a8e0-87a91941ccfe",
  }
}

data "azurerm_policy_definition" "audit_guardrails_az_kv_policy_definitions" {
  for_each = local.audit_guardrails_az_kv_policy_ids
  name     = each.value
}

module "audit_guardrails_for_azure_Key_Vault" {
  source                  = "..//modules/initiative"
  initiative_name         = "audit_guardrails_az_kv"
  initiative_display_name = "Enforce recommended guardrails for Azure Key Vault"
  initiative_description  = "Enforce recommended guardrails for Azure Key Vault"
  initiative_category     = "Key Vault"
  management_group_id     = var.intermediate_root_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for definition in data.azurerm_policy_definition.audit_guardrails_az_kv_policy_definitions : definition
  ]
}

# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Backup.html
locals {
  audit_backup_and_recovery_policy_ids = {
    "backup_vaults_immutability_enabled"            = "2514263b-bc0d-4b06-ac3e-f262c0979018",
    "recovery_services_vaults_immutability_enabled" = "d6f6f560-14b7-49a4-9fc8-d2c3a9807868",
    "backup_vaults_multi_user_auth"                 = "c58e083e-7982-4e24-afdc-be14d312389e",
    "recovery_services_vaults_multi_user_auth"      = "c7031eab-0fc0-4cd9-acd0-4497bd66d91a",
    "recovery_services_vaults_soft_delete"          = "31b8092a-36b8-434b-9af7-5ec844364148",
    "backup_vaults_soft_delete"                     = "9798d31d-6028-4dee-8643-46102185c016",
  }
}

data "azurerm_policy_definition" "audit_backup_and_recovery_policy_definitions" {
  for_each = local.audit_backup_and_recovery_policy_ids
  name     = each.value
}

module "audit_backup_and_recovery" {
  source                  = "..//modules/initiative"
  initiative_name         = "audit_backup_and_recovery"
  initiative_display_name = "Enforce enhanced recovery and backup policies"
  initiative_description  = "Enforce enhanced recovery and backup policies on assigned scopes."
  initiative_category     = "Backup"
  management_group_id     = var.intermediate_root_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = [
    for definition in data.azurerm_policy_definition.audit_backup_and_recovery_policy_definitions : definition
  ]
}

# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-AUM-CheckUpdates.html
locals {
  modify_aum_check_updates_policy_ids = {
    "arc_servers_periodic_update_check"      = "bfea026e-043f-4ff4-9d1b-bf301ca7ff46",
    "virtual_machines_periodic_update_check" = "59efceea-0c96-497e-a4a1-4eb2290dac15",
  }
}

data "azurerm_policy_definition" "modify_aum_check_updates_policy_definitions" {
  for_each = local.modify_aum_check_updates_policy_ids
  name     = each.value
}

module "modify_aum_check_updates" {
  source                  = "..//modules/initiative"
  initiative_name         = "modify_aum_check_updates"
  initiative_display_name = "Configure periodic checking for missing system updates on azure virtual machines and Arc-enabled virtual machines"
  initiative_description  = "Configure auto-assessment (every 24 hours) for OS updates. You can control the scope of assignment according to machine subscription, resource group, location or tag. Learn more about this for Windows: https://aka.ms/computevm-windowspatchassessmentmode, for Linux: https://aka.ms/computevm-linuxpatchassessmentmode."
  initiative_category     = "Security Center"
  merge_parameters        = false
  management_group_id     = var.intermediate_root_management_group_id
  initiative_version      = "1.0.0"
  member_definitions = [
    for definition in data.azurerm_policy_definition.modify_aum_check_updates_policy_definitions : definition
  ]
}

# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deny-PublicPaaSEndpoints.html
locals {
  audit_public_paas_endpoints_policy_ids = {
    "cognitive_services_disable_public"    = "0725b4dd-7e76-479c-a735-68e7ee23d5ca",
    "key_vault_managed_hsm_disable_public" = "19ea9d63-adee-4431-a95e-1913c6c1c75f",
    "recovery_vault_disable_public"        = "9ebbbba3-4d65-4da9-bb67-b22cfaaff090",
    "storage_disable_public_access"        = "4fa4b6c0-31ca-4c0d-b10d-24b96f62a751",
    "api_mgmt_disable_public"              = "df73bd95-24da-4a4f-96b9-4e8b94b402bd",
    "app_config_disable_public"            = "3d9f5e4c-9947-4579-9539-2a7695fbc187",
    "app_service_slots_disable_public"     = "701a595d-38fb-4a66-ae6d-fb3735217622",
    "app_service_disable_public"           = "1b5ef780-c53c-4a64-87f3-bb9c8c8094ba",
    "app_env_disable_public"               = "2d048aca-6479-4923-88f5-e2ac295d9af3",
    "automation_accts_disable_public"      = "955a914f-bf86-4f0e-acd5-e0766b0efcb6",
    "ai_services_restrict_network"         = "037eea7a-bd0a-46c5-9a66-03aea78705d3",
    "redis_disable_public_access"          = "470baccb-7e51-4549-8b1a-3e5be069f663",
    "cognitive_search_disable_public"      = "ee980b6d-0eca-4501-8d54-f6290fd512c3",
    "cosmos_db_disable_public"             = "797b37f7-06b8-444c-b1ad-fc62867f335a",
    "event_grid_domain_disable_public"     = "f8f774be-6aee-492a-9e29-486ef81f3a68",
    "event_grid_topic_disable_public"      = "1adadefe-5f21-44f7-b931-a59b54ccdb45",
    "key_vault_disable_public"             = "405c5871-3e91-4644-8a63-58e19d68ff5b",
    "aks_private_cluster_enabled"          = "040732e8-d947-40b8-95d6-854c95024bf8",
    "ml_workspace_disable_public"          = "438c38d2-3772-465a-a9cc-7a6666a275ce",
    "grafana_disable_public"               = "e8775d5a-73b7-4977-a39b-833ef0114628",
    "sql_managed_inst_disable_public"      = "9dfea752-dd46-4766-aed1-c355fa93fb91",
    "synapse_disable_public"               = "38d8df46-cf4e-4073-8e03-48c24b29de0d",
    "vdi_hostpool_disable_public"          = "c25dcf31-878f-4eba-98eb-0818fdc6a334",
    "vdi_workspace_disable_public"         = "87ac3038-c07a-4b92-860d-29e270a4f3cd",
    "bot_service_disable_public"           = "5e8168db-69e3-4beb-9822-57cb59202a9d",
    "container_apps_env_disable_public"    = "d074ddf8-01a5-4b5e-a2b8-964aed452c0a",
    "container_apps_disable_external"      = "783ea2a8-b8fd-46be-896a-9ae79643a0b1",
    "event_hub_disable_public"             = "0602787f-9896-402a-a6e1-39ee63ee435e",
    "function_app_slots_disable_public"    = "11c82d0c-db9f-4d7b-97c5-f3f9aa957da2",
    "function_app_disable_public"          = "969ac98b-88a8-449f-883c-2e9adb123127",
    "managed_disks_disable_public"         = "8405fdab-1faf-48aa-b702-999c9c172094",
    "data_explorer_disable_public"         = "43bc7be6-5e69-4b0d-a2bb-e815557ca673",
    "data_factory_disable_public"          = "1cf164be-6819-4a50-b8fa-4bcaa4f98fb6",
    "sql_database_disable_public"          = "1b8ca024-1d5c-4dec-8995-b1a932b41780",
    "file_sync_disable_public"             = "21a8cd35-125e-4d13-b82d-2e19b7208bb7",
    "batch_acct_disable_public"            = "74c5a0ae-5e48-4738-b093-65e23a060488",
    "container_reg_disable_public"         = "0fdf0491-d080-4575-b627-ad0e843cba0f",
    "mariadb_disable_public"               = "fdccbe47-f3e3-4213-ad5d-ea459b2fa077",
    "mysql_flexible_disable_public"        = "c9299215-ae47-4f50-9c54-8a392f68a052",
    "mysql_disable_public"                 = "d9844e8a-1437-4aeb-a32c-0c992f056095",
    "postgres_flexible_disable_public"     = "5e1de0e3-42cb-4ebc-a86d-61d0c619ca48",
    "postgres_disable_public"              = "b52376f7-9612-48a1-81cd-1ffe4b61032c",
    "service_bus_disable_public"           = "cbd11fd3-3002-4907-b6c8-579f0e700e13",
    "storage_acct_disable_public"          = "b2982f36-99f2-4db5-8eff-283140c09693"
  }
}

data "azurerm_policy_definition" "audit_public_paas_endpoints_policy_definitions" {
  for_each = local.audit_public_paas_endpoints_policy_ids
  name     = each.value
}

module "audit_public_paas_endpoints_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "audit_public_paas_endpoints*.json"))
  file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
  management_group_id = var.intermediate_root_management_group_id
}

module "audit_public_paas_endpoints" {
  source                  = "..//modules/initiative"
  initiative_name         = "audit_public_paas_endpoints"
  initiative_display_name = "Public network access should be disabled for PaaS services"
  initiative_description  = "This policy initiative is a group of policies that prevents creation of Azure PaaS services with exposed public endpoints"
  initiative_category     = "Network"
  management_group_id     = var.intermediate_root_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for definition in data.azurerm_policy_definition.audit_public_paas_endpoints_policy_definitions : definition],
    [for policy in module.audit_public_paas_endpoints_custom_policy_definitions : policy.definition]
  )
}

# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-Private-DNS-Zones.html
locals {
  dine_private_dns_zones_policy_ids = {
    "configure_recovery_services_vaults_private_dns_zones" = "942bd215-1a66-44be-af65-6a1c0318dbe2",
    "configure_recovery_services_backup_private_dns_zones" = "af783da1-4ad1-42be-800d-d19c70038820",
    "configure_blob_groupid_dns_zone"                      = "75973700-529f-4de2-b794-fb9b6781b6b0",
    "configure_blob_secondary_dns_zone"                    = "d847d34b-9337-4e2d-99a5-767e5ac9c582",
    "configure_dfs_groupid_dns_zone"                       = "83c6fe0f-2316-444a-99a1-1ecd8a7872ca",
    "configure_dfs_secondary_dns_zone"                     = "90bd4cb3-9f59-45f7-a6ca-f69db2726671",
    "configure_file_groupid_dns_zone"                      = "6df98d03-368a-4438-8730-a93c4d7693d6",
    "configure_queue_groupid_dns_zone"                     = "bcff79fb-2b0d-47c9-97e5-3023479b00d1",
    "configure_queue_secondary_dns_zone"                   = "da9b4ae8-5ddc-48c5-b9c0-25f8abf7a3d6",
    "configure_table_groupid_dns_zone"                     = "028bbd88-e9b5-461f-9424-a1b63a7bee1a",
    "configure_table_secondary_dns_zone"                   = "c1d634a5-f73d-4cdd-889f-2cc7006eb47f",
    "configure_web_groupid_dns_zone"                       = "9adab2a5-05ba-4fbd-831a-5bf958d04218",
    "configure_web_secondary_dns_zone"                     = "d19ae5f1-b303-4b82-9ca8-7682749faf0c",
    "configure_app_service_dns_zone"                       = "b318f84a-b872-429b-ac6d-a01b96814452",
    "configure_azure_arc_private_dns_zones"                = "55c4db33-97b0-437b-8469-c4f4498f5df9",
    "configure_azure_automation_private_dns_zones"         = "6dd01e4f-1be1-4e80-9d0b-d109e04cb064",
    "configure_azure_cache_redis_dns_zones"                = "e016b22b-e0eb-436d-8fd7-160c4eaed6e2",
    "configure_cognitive_search_dns_zones"                 = "fbc14a67-53e4-4932-abcc-2049c6706009",
    "configure_databricks_workspace_dns_zones"             = "0eddd7f3-3d9b-4927-a07a-806e8ac9486c",
    "configure_device_update_dns_zones"                    = "a222b93a-e6c2-4c01-817f-21e092455b2a",
    "configure_azure_file_sync_dns_zones"                  = "06695360-db88-47f6-b976-7500d4297475",
    "configure_hdinsight_clusters_dns_zones"               = "43d6e3bd-fc6a-4b44-8b4d-2151d8736a11",
    "configure_key_vault_dns_zones"                        = "ac673a9a-f77d-4846-b2d8-a57f8e1c01d4",
    "configure_ml_workspace_dns_zones"                     = "ee40564d-486e-4f68-a5ca-7a621edae0fb",
    "configure_managed_grafana_dns_zones"                  = "4c8537f8-cd1b-49ec-b704-18e82a42fd58",
    "configure_media_services_dns_zones"                   = "b4a7f6c1-585e-4177-ad5b-c2c93f4bb991",
    "configure_migrate_resources_dns_zones"                = "7590a335-57cf-4c95-babd-ecbc8fafeb1f",
    "configure_monitor_private_link_dns_zones"             = "437914ee-c176-4fff-8986-7e05eb971365",
    "configure_synapse_workspaces_dns_zones"               = "1e5ed725-f16c-478b-bd4b-7bfa2f7940b9",
    "configure_vdi_hostpool_dns_zones"                     = "9427df23-0f42-4e1e-bf99-a6133d841c4a",
    "configure_vdi_workspace_dns_zones"                    = "34804460-d88b-4922-a7ca-537165e060ed",
    "configure_web_pubsub_dns_zones"                       = "0b026355-49cb-467b-8ac4-f777874e175a",
    "configure_bot_service_dns_zones"                      = "6a4e6f44-f2af-4082-9702-033c9e88b9f8",
    "configure_cognitive_services_dns_zones"               = "c4bc6f10-cb41-49eb-b000-d5ab82e2a091",
    "configure_container_registries_dns_zones"             = "e9585a95-5b8c-4d03-b193-dc7eb5ac4c32",
    "configure_cosmosdb_dns_zones"                         = "a63cc0bd-cda4-4178-b705-37dc439d3e0f",
    "configure_disk_access_dns_zones"                      = "bc05b96c-0b36-4ca9-82f0-5c53f96ce05a",
    "configure_event_hub_dns_zones"                        = "ed66d4f5-8220-45dc-ab4a-20d1749c74e6",
    "configure_iot_hub_dns_zones"                          = "aaa64d2d-2fa3-45e5-b332-0b031b9b30e8",
    "configure_app_config_private_endpoints_dns"           = "7a860e27-9ca2-4fc6-822d-c2d248c300df",
    "configure_data_factory_private_endpoints_dns"         = "86cd96e1-1745-420d-94d4-d3f2fe415aa4",
    "configure_service_bus_dns_zones"                      = "f0fcf93c-c063-4071-9668-c47474bd3564",
    "deploy_event_grid_domains_dns_zones"                  = "d389df0a-e0d7-4607-833c-75a6fdac2c2d",
    "deploy_event_grid_topics_dns_zones"                   = "baf19753-7502-405f-8745-370519b20483",
    "deploy_iot_hubs_dns_zones"                            = "c99ce9c1-ced7-4c3e-aca0-10e69ce0cb02",
    "deploy_iot_central_dns_zones"                         = "d627d7c6-ded5-481a-8f2e-7e16b1e6faf6",
    "deploy_signalr_private_endpoints_dns"                 = "b0e86710-7fb7-4a6c-a064-32e9b829509e",
    "deploy_batch_accounts_private_endpoints_dns"          = "4ec38ebc-381f-45ee-81a4-acbc4be878f8"
  }
}

data "azurerm_policy_definition" "dine_private_dns_zones_policy_definitions" {
  for_each = local.dine_private_dns_zones_policy_ids
  name     = each.value
}

module "dine_private_dns_zones" {
  source                  = "..//modules/initiative"
  initiative_name         = "dine_private_dns_zones"
  initiative_display_name = "Configure Azure PaaS services to use private DNS zones"
  initiative_description  = "This policy initiative is a group of policies that ensures private endpoints to Azure PaaS services are integrated with Azure Private DNS zones"
  initiative_category     = "Network"
  merge_parameters        = false
  management_group_id     = var.intermediate_root_management_group_id
  initiative_version      = "1.0.0"
  member_definitions = [
    for definition in data.azurerm_policy_definition.dine_private_dns_zones_policy_definitions : definition
  ]
}

# # This definition set for tag governance according to specific requirements
module "enforce_tag_specification_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "enforce_tag_specification*.json"))
  file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
  management_group_id = var.intermediate_root_management_group_id
}

module "enforce_tag_specification" {
  source                  = "..//modules/initiative"
  initiative_name         = "enforce_tag_specification"
  initiative_display_name = "Enforce tag according to specific requirements"
  initiative_description  = "Enforce tag according to specific requirements"
  initiative_category     = "Tags"
  merge_parameters        = false
  initiative_version      = "1.0.0"
  management_group_id     = var.intermediate_root_management_group_id
  member_definitions = [
    for policy in module.enforce_tag_specification_custom_policy_definitions : policy.definition
  ]
}

# # This definition set for hardened image from trusted source
module "deny_sources_without_trusted_image_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/intermediate_root/", "deny_sources_without_trusted_image*.json"))
  file_path           = "${path.module}/../custom_policy/intermediate_root/${each.value}"
  management_group_id = var.intermediate_root_management_group_id
}

data "azurerm_policy_definition" "k8s_allowed_images_policy_definitions" {
  name = "febd0533-8e55-448f-b837-bd0e06f16469"
}

module "deny_sources_without_trusted_image" {
  source                  = "..//modules/initiative"
  initiative_name         = "deny_sources_without_trusted_image"
  initiative_display_name = "Enforce trusted image from trusted source"
  initiative_description  = "Enforce trusted image from trusted source"
  initiative_category     = "Image"
  management_group_id     = var.intermediate_root_management_group_id
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for policy in module.deny_sources_without_trusted_image_custom_policy_definitions : policy.definition],
    [data.azurerm_policy_definition.k8s_allowed_images_policy_definitions]
  )
}

# https://www.azadvertizer.net/azpolicyadvertizer/Deny-PublicIP.html
module "deny_public_ip" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/intermediate_root/deny_public_ip.json"
  management_group_id = var.intermediate_root_management_group_id
}

# https://www.azadvertizer.net/azpolicyadvertizer/Deny-Subnet-Without-Nsg.html
module "deny_subnet_without_nsg" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/intermediate_root/deny_subnet_without_nsg.json"
  management_group_id = var.intermediate_root_management_group_id
}

# https://www.azadvertizer.net/azpolicyadvertizer/Deny-MgmtPorts-From-Internet.html
module "deny_mgmt_ports_from_internet" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/intermediate_root/deny_mgmt_ports_from_internet.json"
  management_group_id = var.intermediate_root_management_group_id
}

# https://www.azadvertizer.net/azpolicyadvertizer/Audit-PrivateLinkDnsZones.html
module "audit_private_link_dns_zones" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/intermediate_root/audit_private_link_dns_zones.json"
  management_group_id = var.intermediate_root_management_group_id
}

