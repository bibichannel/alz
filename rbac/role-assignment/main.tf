resource "azurerm_role_assignment" "this" {
  for_each = local.role_assignments
  
#   name                             = each.value.name
  description                      = each.value.description
  scope                            = each.value.scope
  principal_type                   = each.value.principal_type
  principal_id                     = each.value.principal_id
  role_definition_id               = each.value.role_definition_id
#   condition                        = each.value.condition
}
