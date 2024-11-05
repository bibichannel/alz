data "azurerm_management_group" "contoso" {
  name = "testing_mg"
}

module "definitions" {
  source                                = ".//definitions"
  intermediate_root_management_group_id = data.azurerm_management_group.contoso.id
  foundations_management_group_id       = data.azurerm_management_group.contoso.id
  landing_zones_management_group_id     = data.azurerm_management_group.contoso.id
}

output "list_param_01" {
  value = module.definitions.list_of_initiative_parameters_01
}

output "list_param_02" {
  value = module.definitions.list_of_initiative_parameters_02
}