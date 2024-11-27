resource "azurerm_monitor_action_group" "example" {
  name                = "Budget Threshold Alerts Action"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "budget_ac"

  email_receiver {
    name          = "bibichannel"
    email_address = "trung.khanh150901@gmail.com"
  }

  logic_app_receiver {
    name                    = "logicappaction"
    resource_id             = azurerm_logic_app_workflow.budget-workflow.id
    callback_url            = azurerm_logic_app_trigger_http_request.trigger.callback_url
    use_common_alert_schema = true
  }
}