data "azurerm_client_config" "current" {}

data "azurerm_role_definition" "role_definitions" {
  for_each = var.role_definitions

  name               = each.value.name
  role_definition_id = each.value.id
  scope              = each.value.scope
}

locals {
  azuread_groups = toset(flatten([
    var.role_aasignment_at_mg_matrix != null && length(var.role_aasignment_at_mg_matrix) > 0
    ? [for item in var.role_aasignment_at_mg_matrix : item.group]
    : [],
    var.role_aasignment_at_sub_matrix != null && length(var.role_aasignment_at_sub_matrix) > 0
    ? [for item in var.role_aasignment_at_sub_matrix : item.group]
    : [],
    var.role_aasignment_at_rg_matrix != null && length(var.role_aasignment_at_rg_matrix) > 0
    ? [for item in var.role_aasignment_at_rg_matrix : item.group]
    : []
  ]))
}

data "azuread_group" "this" {
  for_each     = local.azuread_groups
  display_name = each.key
}


locals {
  default_subscription_id            = data.azurerm_client_config.current.subscription_id
  management_group_role_scope_format = "/providers/Microsoft.Management/managementGroups/%s"
  subscription_role_scope_format     = "/subscriptions/%s"
  resource_group_role_scope_format   = "/subscriptions/%s/resourceGroups/%s"

  role_assignments_for_management_group = (
    var.role_aasignment_at_mg_matrix != null && length(var.role_aasignment_at_mg_matrix) > 0 ? [
      for item in var.role_aasignment_at_mg_matrix : {
        description        = item.description
        scope              = format(local.subscription_role_scope_format, item.scope)
        principal_type     = "Group"
        principal_id       = data.azuread_group.this[item.group].object_id
        role_definition_id = data.azurerm_role_definition.role_definitions[lower(item.role)].id
        condition          = item.condition
    }] : []
  )

  role_assignments_for_subscription = (
    var.role_aasignment_at_sub_matrix != null && length(var.role_aasignment_at_sub_matrix) > 0 ? [
      for item in var.role_aasignment_at_sub_matrix : {
        description        = item.description
        scope              = format(local.subscription_role_scope_format, item.scope == null ? local.default_subscription_id : item.scope)
        principal_type     = "Group"
        principal_id       = data.azuread_group.this[item.group].object_id
        role_definition_id = data.azurerm_role_definition.role_definitions[lower(item.role)].id
        condition          = item.condition
    }] : []
  )

  role_assignments_for_resource_group = (
    var.role_aasignment_at_rg_matrix != null && length(var.role_aasignment_at_rg_matrix) > 0 ? [
      for item in var.role_aasignment_at_rg_matrix : {
        description        = item.description
        scope              = format(local.resource_group_role_scope_format, item.subscription == null ? local.default_subscription_id : item.subscription, item.scope)
        principal_type     = "Group"
        principal_id       = data.azuread_group.this[item.group].object_id
        role_definition_id = data.azurerm_role_definition.role_definitions[lower(item.role)].id
        condition          = item.condition
    }] : []
  )

  role_assignments = flatten([
    for assignment in concat(
      local.role_assignments_for_management_group,
      local.role_assignments_for_subscription,
      local.role_assignments_for_resource_group
      ) : {
      description        = assignment.description
      scope              = assignment.scope
      principal_type     = assignment.principal_type
      principal_id       = assignment.principal_id
      role_definition_id = assignment.role_definition_id
      condition          = assignment.condition != "" ? assignment.condition : null
    }
  ])

}

output "role_assignments" {
  value = local.role_assignments
}

output "azuread_groups" {
  value = local.azuread_groups
}