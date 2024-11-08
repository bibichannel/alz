# data "azurerm_policy_definition" "testing" {
#   name     = "6c112d4e-5bc7-47ae-a041-ea2d9dccd749"
# }

# module "builtin_definitions_assignment" {
#   source   = "../modules/def_assignment"

#   definition                  = data.azurerm_policy_definition.testing
#   assignment_scope            = local.assignment_scope_id
#   assignment_effect = "Disabled"
#   assignment_name = "testing"
#   assignment_parameters = {
#     "listOfResourceTypesNotAllowed": ["EC2"]
#   }
# }