data "azurerm_subscription" "current" {}

data "local_file" "trigger" {
  filename = "${path.module}/workflow/trigger/trigger.json"
}

data "azurerm_managed_api" "outlook" {
  name     = "outlook"
  location = azurerm_resource_group.this.location
}
