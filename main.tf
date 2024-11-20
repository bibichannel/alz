data "azurerm_management_group" "contoso" {
  name = "testing_mg"
}

module "definitions" {
  source                                = ".//definitions"
  intermediate_root_management_group_id = data.azurerm_management_group.contoso.id
  landing_zones_management_group_id     = data.azurerm_management_group.contoso.id
  connectivity_management_group_id      = data.azurerm_management_group.contoso.id
  identity_management_group_id          = data.azurerm_management_group.contoso.id
  management_management_group_id        = data.azurerm_management_group.contoso.id
  security_management_group_id          = data.azurerm_management_group.contoso.id
  legacy_management_group_id            = data.azurerm_management_group.contoso.id
  decommissioned_management_group_id    = data.azurerm_management_group.contoso.id
  sandbox_management_group_id           = data.azurerm_management_group.contoso.id
}

output "path_module" {
  value = module.definitions.path_module
}

module "caps" {
  source = "./cap"
}

