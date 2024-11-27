# data "azurerm_subscription" "current" {}

data "local_file" "logic_app" {
  filename = "${path.module}/workflow.json"
}

data "local_file" "trigger" {
  filename = "${path.module}/workflow/trigger/trigger.json"
}