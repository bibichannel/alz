locals {
  definition_location    = var.architype.definition_location
  assignment_scope_id    = var.architype.assignment_scope_id
  builtin_definitions    = [for def in var.architype.builtin_definitions : def]
  custom_definitions     = [for def in var.architype.custom_definitions : def]
  builtin_defnition_sets = [for def in var.architype.builtin_defnition_sets : def]
  custom_defnition_sets  = [for def in var.architype.custom_defnition_sets : def]
}

# Define a data source that fetches information based on definition ID
data "azurerm_policy_definition" "builtin_policy_definitions" {
  for_each = toset([for d in local.builtin_definitions : d.definition])
  name     = each.key
}

data "azurerm_policy_definition" "custom_policy_definitions" {
  for_each              = toset([for d in local.custom_definitions : d.definition])
  name                  = each.key
  management_group_name = local.definition_location
}

data "azurerm_policy_set_definition" "builtin_definition_sets" {
  for_each = toset([for d in local.builtin_defnition_sets : d.initiative])
  name     = each.key
}

data "azurerm_policy_set_definition" "custom_definition_sets" {
  for_each              = toset([for d in local.custom_defnition_sets : d.initiative])
  name                  = each.key
  management_group_name = local.definition_location
}

locals {
  builtin_definitions_updated = [
    for def in local.builtin_definitions : merge(
      def,
      { definition = data.azurerm_policy_definition.builtin_policy_definitions[def.definition] }
    )
  ]

  custom_definitions_updated = [
    for def in local.custom_definitions : merge(
      def,
      { definition = data.azurerm_policy_definition.custom_policy_definitions[def.definition] }
    )
  ]

  builtin_defnition_sets_updated = [
    for def in local.builtin_defnition_sets : merge(
      def,
      { initiative = data.azurerm_policy_set_definition.builtin_definition_sets[def.initiative] }
    )
  ]

  custom_defnition_sets_updated = [
    for def in local.custom_defnition_sets : merge(
      def,
      { initiative = data.azurerm_policy_set_definition.custom_definition_sets[def.initiative] }
    )
  ]
}


output "builtin_definitions_updated" {
  value = local.builtin_definitions_updated
}

output "custom_definitions_updated" {
  value = local.custom_definitions_updated
}

output "builtin_defnition_sets_updated" {
  value = local.builtin_defnition_sets_updated
}

output "custom_defnition_sets_updated" {
  value = local.custom_defnition_sets_updated
}