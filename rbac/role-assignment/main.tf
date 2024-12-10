resource "azurerm_role_assignment" "this" {
  for_each = { for idx, assignment in local.role_assignments : idx => assignment }

  description        = each.value.description
  scope              = each.value.scope
  principal_type     = each.value.principal_type
  principal_id       = each.value.principal_id
  role_definition_id = each.value.role_definition_id
  condition          = each.value.condition
}
