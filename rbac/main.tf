data "azurerm_subscription" "primary" {
}

data "azurerm_management_group" "consoto" {
  name = "testing_mg"
}

locals {
  architype = jsondecode(file("${path.module}/roleDefinition.json"))
}

locals {
  subs_csv_content = file("${path.module}/roleAssignmentAtSubcriptions.csv")
  rg_csv_content   = file("${path.module}/roleAssignmentAtResourceGroup.csv")

  subs_clean_csv_content = replace(local.subs_csv_content, "\ufeff", "")
  rg_clean_csv_content   = replace(local.rg_csv_content, "\ufeff", "")

  subs_matrix = csvdecode(local.subs_clean_csv_content)
  rg_matrix   = csvdecode(local.rg_clean_csv_content)
}

module "role_definition" {
  source    = "./role-definition"
  architype = local.architype
  scope_map = [
    { key = "test", value = data.azurerm_subscription.primary.id }
  ]
}

module "role_assignments" {
  source                        = "./role-assignment"
  role_aasignment_at_mg_matrix  = []
  role_aasignment_at_sub_matrix = local.subs_matrix
  role_aasignment_at_rg_matrix  = local.rg_matrix
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
      id = module.role_definition.custom_roles["IdOps"].role_definition_id
    }
    custom_role_by_id = {
      id = module.role_definition.custom_roles["NetOps"].role_definition_id
    }
  }
}

output "subs_id" {
  value = data.azurerm_subscription.primary.id
}