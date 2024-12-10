data "azurerm_role_definition" "role_definitions" {
  for_each = var.role_definitions

  name               = each.value.name
  role_definition_id = each.value.id
  scope              = each.value.scope
}

data "azuread_group" "this" {
  for_each =  toset([for item in var.role_aasignment_matrix : item.group])
  display_name     = each.key
}

locals {
  role_assignments = [
    for item in var.role_aasignment_matrix : {
    #   name               = item.name
      description        = item.description
      scope              = "/providers/Microsoft.Management/managementGroups/${item.scope}"
      principal_type    = "Group"
      principal_id      = data.azuread_group.this[item.group].id
      role_definition_id = data.azurerm_role_definition.role_definitions[item.role].id
    #   condition          = item.condition
    }
  ]
}

output "role_assignments" {
  value = local.role_assignments
}