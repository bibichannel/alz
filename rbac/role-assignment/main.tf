# resource "azurerm_role_assignment" "this" {
#   for_each = local.role_assignments

#   principal_id                     = each.value.principal_id
#   scope                            = each.value.scope
#   principal_type                   = each.value.principal_type
#   description                      = each.value.description
#   role_definition_id               = each.value.role_definition_id
#   condition                        = each.value.condition
# }
