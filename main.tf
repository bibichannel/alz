data "azurerm_management_group" "contoso" {
  name = "testing_mg"
}

module "definitions" {
  source                                = ".//definitions"
  intermediate_root_management_group_id = data.azurerm_management_group.contoso.id
  foundations_management_group_id       = data.azurerm_management_group.contoso.id
  landing_zones_management_group_id     = data.azurerm_management_group.contoso.id
}
