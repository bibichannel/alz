data "azurerm_management_group" "contoso" {
  name = "testing_mg"
}

# module "definitions" {
#   source                                = ".//../definitions"
#   intermediate_root_management_group_id = data.azurerm_management_group.contoso.id
#   landing_zones_management_group_id     = data.azurerm_management_group.contoso.id
#   connectivity_management_group_id      = data.azurerm_management_group.contoso.id
#   identity_management_group_id          = data.azurerm_management_group.contoso.id
#   management_management_group_id        = data.azurerm_management_group.contoso.id
#   security_management_group_id          = data.azurerm_management_group.contoso.id
#   legacy_management_group_id            = data.azurerm_management_group.contoso.id
#   decommissioned_management_group_id    = data.azurerm_management_group.contoso.id
#   sandbox_management_group_id           = data.azurerm_management_group.contoso.id
# }

# module "caps" {
#   source = "./cap"  
# }

# module "budget" {
#   source = "./budget"
# }

# module "rbac" {
#   source = "./rbac"
# }