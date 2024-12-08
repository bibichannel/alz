resource "azurerm_user_assigned_identity" "this" {
  location            = azurerm_resource_group.this.location
  name                = "budget-MI"
  resource_group_name = azurerm_resource_group.this.name
}

resource "azurerm_role_assignment" "identity_logic_app" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Resource Policy Contributor"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
} 


resource "azurerm_role_assignment" "reader_role" {
  scope                = azurerm_resource_group.this.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.this.principal_id
} 

resource "azurerm_resource_group" "this" {
  name     = var.resource_group_name
  location = "East US"
}