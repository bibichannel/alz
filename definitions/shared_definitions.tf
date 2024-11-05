# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Guardrails-KeyVault.html
# locals {
#   audit_guardrails_az_kv_policy_ids = {
#     "key_vault_managed_hsm_keys_expiration"             = "1d478a74-21ba-4b9f-9d8f-8e6fced0eec5",
#     "key_vault_managed_hsm_keys_days_before_expiration" = "ad27588c-0198-4c84-81ef-08efd0274653",
#     "key_vault_managed_hsm_keys_curve_names"            = "e58fd0c1-feac-4d12-92db-0a7e9421f53e",
#     "key_vault_managed_hsm_keys_min_rsa_size"           = "86810a98-8e91-4a44-8386-ec66d0de5d57",
#     "key_vault_managed_hsm_purge_protection"            = "c39ba22d-4428-4149-b981-70acb31fc383",
#     "key_vault_firewall_enabled"                        = "55615ac9-af46-4a59-874e-391cc3dfb490",
#     "key_vault_rbac_permission_model"                   = "12d4fa5e-1f9f-4c21-97a9-b99b3c6611b5",
#     "certificates_integrated_issuer"                    = "8e826246-c976-48f6-b03e-619bb92b3d82",
#     "certificates_non_integrated_issuer"                = "a22f4a40-01d3-4c7d-8071-da157eeff341",
#     "certificates_lifetime_action_triggers"             = "12ef42cb-9903-4e39-9c26-422d29570417",
#     "certificates_max_validity_period"                  = "0a075868-4c26-42ef-914c-5bc007359560",
#     "certificates_days_until_expiration"                = "f772fb64-8e40-40ad-87bc-7706e1949427",
#     "certificates_allowed_key_types"                    = "1151cede-290b-4ba0-8b38-0ad145ac888f",
#     "certificates_curve_names_ec"                       = "bd78111f-4953-4367-9fd5-7e08808b54bf",
#     "certificates_min_rsa_key_size"                     = "cee51871-e572-4576-855c-047c820360f0",
#     "key_vault_keys_expiration"                         = "152b15f7-8e1f-4c1f-ab71-8c010ba5dbc0",
#     "key_vault_secrets_expiration"                      = "98728c90-32c7-4049-8429-847dc0f4fe37",
#     "key_vault_deletion_protection"                     = "0b60c0b2-2dc2-4e1c-b5c9-abbed971de53",
#     "key_vault_soft_delete"                             = "1e66c121-a66a-4b1f-9b83-0fd99bf0fc2d",
#     "keys_cryptographic_type"                           = "75c4f823-d65c-4f29-a733-01d0077fdbcb",
#     "keys_days_before_expiration"                       = "5ff38825-c5d8-47c5-b70e-069a21955146",
#     "keys_max_validity_period"                          = "49a22571-d204-4c91-a7b6-09b1a586fbc9",
#     "keys_max_active_duration"                          = "c26e4b24-cf98-4c67-b48b-5a25c4c69eb9",
#     "keys_curve_names_ec"                               = "ff25f3c8-b739-4538-9d07-3d6d25cfb255",
#     "keys_min_rsa_key_size"                             = "82067dbb-e53b-4e06-b631-546d197452d9",
#     "secrets_content_type_set"                          = "75262d3e-ba4a-4f43-85f8-9f72c090e5e3",
#     "secrets_days_before_expiration"                    = "b0eb591a-5e70-4534-a8bf-04b9c489584a",
#     "secrets_max_validity_period"                       = "342e8053-e12e-4c44-be01-c3c2f318400f",
#     "secrets_max_active_duration"                       = "e8d99835-8a06-45ae-a8e0-87a91941ccfe",
#   }
# }

# data "azurerm_policy_definition" "audit_guardrails_az_kv_policy_definitions" {
#   for_each = local.audit_guardrails_az_kv_policy_ids
#   name     = each.value
# }

# module "audit_guardrails_for_azure_Key_Vault" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "audit_guardrails_az_kv"
#   initiative_display_name = "Enforce recommended guardrails for Azure Key Vault"
#   initiative_description  = "Enforce recommended guardrails for Azure Key Vault"
#   initiative_category     = "Key Vault"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.audit_guardrails_az_kv_policy_definitions : definition
#   ]
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Backup.html
# locals {
#   audit_backup_and_recovery_policy_ids = {
#     "backup_vaults_immutability_enabled"            = "2514263b-bc0d-4b06-ac3e-f262c0979018",
#     "recovery_services_vaults_immutability_enabled" = "d6f6f560-14b7-49a4-9fc8-d2c3a9807868",
#     "backup_vaults_multi_user_auth"                 = "c58e083e-7982-4e24-afdc-be14d312389e",
#     "recovery_services_vaults_multi_user_auth"      = "c7031eab-0fc0-4cd9-acd0-4497bd66d91a",
#     "recovery_services_vaults_soft_delete"          = "31b8092a-36b8-434b-9af7-5ec844364148",
#     "backup_vaults_soft_delete"                     = "9798d31d-6028-4dee-8643-46102185c016",
#   }
# }

# data "azurerm_policy_definition" "audit_backup_and_recovery_policy_definitions" {
#   for_each = local.audit_backup_and_recovery_policy_ids
#   name     = each.value
# }

# module "audit_backup_and_recovery" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "audit_backup_and_recovery"
#   initiative_display_name = "Enforce enhanced recovery and backup policies"
#   initiative_description  = "Enforce enhanced recovery and backup policies on assigned scopes."
#   initiative_category     = "Backup"
#   management_group_id     = var.intermediate_root_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.audit_backup_and_recovery_policy_definitions : definition
#   ]
# }

# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-AUM-CheckUpdates.html
# locals {
#   modify_aum_check_updates_policy_ids = {
#     "arc_servers_periodic_update_check"      = "bfea026e-043f-4ff4-9d1b-bf301ca7ff46",
#     "virtual_machines_periodic_update_check" = "59efceea-0c96-497e-a4a1-4eb2290dac15",
#   }
# }

# data "azurerm_policy_definition" "modify_aum_check_updates_policy_definitions" {
#   for_each = local.modify_aum_check_updates_policy_ids
#   name     = each.value
# }

# module "modify_aum_check_updates" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "modify_aum_check_updates"
#   initiative_display_name = "Configure periodic checking for missing system updates on azure virtual machines and Arc-enabled virtual machines"
#   initiative_description  = "Configure auto-assessment (every 24 hours) for OS updates. You can control the scope of assignment according to machine subscription, resource group, location or tag. Learn more about this for Windows: https://aka.ms/computevm-windowspatchassessmentmode, for Linux: https://aka.ms/computevm-linuxpatchassessmentmode."
#   initiative_category     = "Security Center"
#   management_group_id     = var.foundations_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.modify_aum_check_updates_policy_definitions : definition
#   ]
# }