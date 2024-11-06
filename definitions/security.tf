# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-Encryption-CMK.html
locals {
  audit_encryption_cmk_policy_ids = {
    "vm_encrypt_temp_disks_caches_flows" = "0961003e-5a0a-4549-abde-af6a37f2724d",
    "recovery_vaults_cmk_backup"         = "2e94d99a-8a36-4563-bc77-810d8893b671",
    "ai_services_cmk_encrypt"            = "67121cc7-ff39-4ab8-b7e3-95b84dab487d",
    "api_fhir_cmk_encrypt"               = "051cba44-2429-45b9-9649-46cec11c7119",
    "automation_accts_cmk_encrypt"       = "56a5ee18-2ae6-4810-86f7-18e39ce5629b",
    "batch_acct_cmk_encrypt"             = "99e9ccd8-3db9-4592-b0d1-14b1715a4d8a",
    "cognitive_search_cmk_encrypt"       = "76a56461-9dc0-40f0-82f5-2453283afa2f",
    "container_inst_cmk_encrypt"         = "0aa61e00-0a01-4a3c-9945-e93cffedf0e6",
    "cosmosdb_cmk_encrypt"               = "1f905d99-2ab7-462c-a6b0-f709acca6c8f",
    "data_box_cmk_unlock_pwd"            = "86efb160-8de7-451d-bc08-5d475b0aadae",
    "data_explorer_cmk_encrypt"          = "81e74cea-30fd-40d5-802f-d72103c2aaaa",
    "data_factories_cmk_encrypt"         = "4ec52d6d-beb7-40c4-9a9e-fe753254690e",
    "ml_workspaces_cmk_encrypt"          = "ba769a63-b8cc-4b2d-abf6-ac33c7204be8",
    "stream_analytics_cmk_encrypt"       = "87ba29ef-1ab3-4d82-b763-87fcd4f531f7",
    "synapse_cmk_encrypt"                = "f7d52b2d-e161-4dfa-a82b-55e564167385",
    "bot_service_cmk_encrypt"            = "51522a96-0869-4791-82f3-981000c2c67f",
    "aks_os_data_cmk_encrypt"            = "7d7be79c-23ba-4033-84dd-45e2a5ccdd67",
    "container_reg_cmk_encrypt"          = "5b9159ae-1701-4a6f-9a7a-aa9c8ddd0580",
    "event_hub_cmk_encrypt"              = "a1ad735a-e96f-45d2-a7b2-9a4932cab7ec",
    "mysql_cmk_encrypt"                  = "83cef61d-dbd1-4b20-a4fc-5fbc7da10833",
    "os_data_disks_cmk_encrypt"          = "702dd420-7fcc-42c5-afe8-4026edd20fe0",
    "postgresql_cmk_encrypt"             = "18adea5e-f416-4d0f-8aa8-d24321e3e274",
    "queue_storage_cmk_encrypt"          = "f0e5abd0-2554-4736-b7c0-4ffef23475ef",
    "service_bus_premium_cmk_encrypt"    = "295fc8b1-dc9f-4f53-9c61-3f313ceab40a",
    "sql_managed_inst_cmk_encrypt"       = "ac01ad65-10e5-46df-bdd9-6b0cad13e1d2",
    "sql_servers_cmk_encrypt"            = "0a370ff3-6cab-4e85-8995-295fd854c5b8",
    "storage_encryption_scope_cmk"       = "b5ec538c-daa0-4006-8596-35468b9148e8",
    "storage_accts_cmk_encrypt"          = "6fac406b-40ca-413b-bf8e-0bf964659c25",
    "table_storage_cmk_encrypt"          = "7c322315-e26d-4174-a99e-f49d351b4688"
  }
}

data "azurerm_policy_definition" "audit_encryption_cmk_policy_definitions" {
  for_each = local.audit_encryption_cmk_policy_ids
  name     = each.value
}

module "audit_encryption_cmk_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/security/", "audit_encryption_cmk*.json"))
  file_path           = "${path.module}/../custom_policy/security/${each.value}"
  management_group_id = var.security_management_group_id
}

module "audit_resources_without_encryption_with_cmk" {
  source                  = "..//modules/initiative"
  initiative_name         = "audit_encryption_cmk"
  initiative_display_name = "Audit resources without Encryption with a customer-managed key (CMK)"
  initiative_description  = "Audit resources without Encryption with a customer-managed key (CMK)"
  initiative_category     = "Encryption"
  management_group_id     = var.security_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for definition in data.azurerm_policy_definition.audit_encryption_cmk_policy_definitions : definition],
    [for policy in module.audit_encryption_cmk_custom_policy_definitions : policy.definition]
  )
}