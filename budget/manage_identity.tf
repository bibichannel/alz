resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = "budget-MI"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_role_assignment" "identity-logicapp" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Resource Policy Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
} 