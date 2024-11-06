# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-ALZ-Decomm.html
locals {
  deny_dine_alz_decommissioned_policy_ids = {
    allowed_resource_types = "a08ec900-254a-4555-9bf5-e42af04b5c5c"
  }
}

data "azurerm_policy_definition" "deny_dine_alz_decommissioned_policy_definitions" {
  for_each = local.deny_dine_alz_decommissioned_policy_ids
  name     = each.value
}

module "deny_dine_alz_decommissioned_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/decommissioned/", "deny_dine_alz_decommissioned*.json"))
  file_path           = "${path.module}/../custom_policy/decommissioned/${each.value}"
  management_group_id = var.decommissioned_management_group_id
}

module "deny_dine_alz_decommissioned" {
  source                  = "..//modules/initiative"
  initiative_name         = "deny_dine_alz_decommissioned"
  initiative_display_name = "Enforce policies in the Decommissioned Landing Zone"
  initiative_description  = "Enforce policies in the Decommissioned Landing Zone."
  initiative_category     = "Decommissioned"
  management_group_id     = var.decommissioned_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for definition in data.azurerm_policy_definition.deny_dine_alz_decommissioned_policy_definitions : definition],
    [for policy in module.deny_dine_alz_decommissioned_custom_policy_definitions : policy.definition]
  )
}