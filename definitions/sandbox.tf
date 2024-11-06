# https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Enforce-ALZ-Sandbox.html
locals {
  deny_alz_sandbox_policy_ids = {
    not_allowed_resource_types = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
  }
}

data "azurerm_policy_definition" "deny_alz_sandbox_policy_definitions" {
  for_each = local.deny_alz_sandbox_policy_ids
  name     = each.value
}

module "deny_alz_sandbox_custom_policy_definitions" {
  source              = "..//modules/definition"
  for_each            = toset(fileset("${path.module}/../custom_policy/sandbox/", "deny_alz_sandbox*.json"))
  file_path           = "${path.module}/../custom_policy/sandbox/${each.value}"
  management_group_id = var.sandbox_management_group_id
}

module "deny_alz_sandbox" {
  source                  = "..//modules/initiative"
  initiative_name         = "deny_alz_sandbox"
  initiative_display_name = "Enforce policies in the Sandbox Landing Zone"
  initiative_description  = "Enforce policies in the Sandbox Landing Zone."
  initiative_category     = "Sandbox"
  management_group_id     = var.sandbox_management_group_id
  merge_effects           = true
  merge_parameters        = false
  initiative_version      = "1.0.0"
  member_definitions = concat(
    [for definition in data.azurerm_policy_definition.deny_alz_sandbox_policy_definitions : definition],
    [for policy in module.deny_alz_sandbox_custom_policy_definitions : policy.definition]
  )
}

# https://www.azadvertizer.net/azpolicyadvertizer/125e78be-b7cd-4fa9-a269-729e6ef27d49.html
module "audit_nsg_rule_inbound_from_internet" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/sandbox/audit_nsg_rule_inbound_from_internet.json"
  management_group_id = var.sandbox_management_group_id
}
