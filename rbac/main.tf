locals {
  architype = jsondecode(file("${path.module}/roleDefinition.json"))
}

locals {
  csv_content       = file("${path.module}/roleAssignment.csv")
  clean_csv_content = replace(local.csv_content, "\ufeff", "")
  matrix            = csvdecode(local.clean_csv_content)
}

data "azurerm_subscription" "primary" {
}

output "subs_id" {
  value = data.azurerm_subscription.primary.id
}

data "azurerm_management_group" "consoto" {
  name = "testing_mg"
}

module "role_definition" {
  source    = "./role-definition"
  architype = local.architype
  scope_map = [
    { key = "consoto", value = data.azurerm_management_group.consoto.id },
    { key = "test", value = data.azurerm_subscription.primary.id }
  ]
}

module "role_assignments" {
  source                 = "./role-assignment"
  role_aasignment_matrix = local.matrix
  role_definitions = {
    contributor = {
      name = "Contributor"
    }
    reader = {
      name = "Reader"
    }
    rbac_administrator = {
      name = "Role Based Access Control Administrator"
    }
    idops = {
      name = "IdOps"
      id   = module.role_definition.custom_roles["IdOps"].id
    }
    custom_role_by_id = {
      name = "NetOps"
      id   = module.role_definition.custom_roles["NetOps"].id
    }
  }
}
