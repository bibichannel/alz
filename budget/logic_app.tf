locals {
    arm_file_path = ""
}

data "template_file" "workflow" {
    template = file(local.arm_file_path)
}

resource "azurerm_resource_group" "this" {
  name     = "workflow-resources"
  location = "West Europe"
}

resource "azurerm_logic_app_workflow" "budget-workflow" {
  name                = "budget-workflow"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
}
