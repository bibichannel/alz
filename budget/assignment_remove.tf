resource "azurerm_logic_app_workflow" "delele_policy_assignemt_workflow" {
  depends_on          = [azurerm_user_assigned_identity.this]
  name                = "delele-policy-assignemt-workflow"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}

resource "azurerm_logic_app_trigger_http_request" "budget_write_alerts_action" {
  name         = "custom-buget-alert"
  logic_app_id = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
  schema       = data.local_file.trigger.content
}

resource "azurerm_logic_app_action_custom" "budget_scope_variable" {
  name = "budget-scope-variable"
  logic_app_id = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
  body = <<BODY
  {
    "runAfter": {},
    "type": "InitializeVariable",
    "inputs": {
      "variables": [
        {
          "name": "budget_scope",
          "type": "string",
          "value": "@split(triggerBody()?['data']?['alertContext']?['authorization']?['scope'], 'providers')[0]"
        }
      ]
    }
  }
  BODY
}

resource "azurerm_logic_app_action_custom" "budget_name_variable" {
  depends_on = [azurerm_logic_app_action_custom.budget_scope_variable]
  name = "budget-name-variable"
  logic_app_id = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
  body = <<BODY
  {
    "runAfter": {
      "${azurerm_logic_app_action_custom.budget_scope_variable.name}": [
        "SUCCEEDED"
      ]
    },
    "type": "InitializeVariable",
    "inputs": {
      "variables": [
        {
          "name": "budget_name",
          "type": "string",
          "value": "@split(triggerBody()?['data']?['alertContext']?['authorization']?['scope'], 'Microsoft.Consumption/budgets/')[1]"
        }
      ]
    }
  }
  BODY
}

resource "azurerm_logic_app_action_custom" "budget_status" {
  depends_on = [azurerm_logic_app_action_custom.budget_name_variable]
  name         = "budget-status"
  logic_app_id = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
  body         = <<BODY
  {
  "runAfter": {
      "${azurerm_logic_app_action_custom.budget_name_variable.name}": [
        "SUCCEEDED"
      ]
    },
    "type": "Http",
    "inputs": {
      "uri": "https://management.azure.com@{variables('budget_scope')}/providers/Microsoft.Consumption/budgets/@{variables('budget_name')}?api-version=2024-08-01",
      "method": "GET",
      "authentication": {
        "type": "ManagedServiceIdentity",
        "identity": "${azurerm_user_assigned_identity.this.id}"
      }
    },
    "runtimeConfiguration": {
      "contentTransfer": {
        "transferMode": "Chunked"
      }
    }
  }
  BODY
}

resource "azurerm_logic_app_action_custom" "budget_status_conditions" {
  depends_on = [azurerm_logic_app_action_custom.budget_status]
  name         = "budget-status-conditions"
  logic_app_id = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
  body         = <<BODY
  {
   "runAfter": {
      "${azurerm_logic_app_action_custom.budget_status.name}": [
        "SUCCEEDED"
      ]
    },
    "type": "If",
    "expression": {
      "and": [
        {
          "lessOrEquals": [
            "@div(float(body('${azurerm_logic_app_action_custom.budget_status.name}')?['properties']?['currentSpend']?['amount']), float(body('${azurerm_logic_app_action_custom.budget_status.name}')?['properties']?['amount']))",
            0.7
          ]
        }
      ]
    },
    "actions": {
      "assignment-status": {
        "type": "Http",
        "inputs": {
          "uri": "https://management.azure.com/@{variables('budget_scope')}/providers/Microsoft.Authorization/policyAssignments/testingassignment?api-version=2023-04-01",
          "method": "GET",
          "authentication": {
            "type": "ManagedServiceIdentity",
            "identity": "${azurerm_user_assigned_identity.this.id}"
          }
        },
        "runtimeConfiguration": {
          "contentTransfer": {
            "transferMode": "Chunked"
          }
        }
      },
      "assignment-status-conditions": {
        "type": "If",
        "expression": {
          "and": [
            {
              "equals": [
                "@outputs('assignment-status')?['statusCode']",
                200
              ]
            }
          ]
        },
        "actions": {
          "delete-policy-assignment": {
            "type": "Http",
            "inputs": {
              "uri": "https://management.azure.com/@{variables('budget_scope')}/providers/Microsoft.Authorization/policyAssignments/testingassignment?api-version=2023-04-01",
              "method": "DELETE",
              "authentication": {
                "type": "ManagedServiceIdentity",
                "identity": "${azurerm_user_assigned_identity.this.id}"
              }
            },
            "runtimeConfiguration": {
              "contentTransfer": {
                "transferMode": "Chunked"
              }
            }
          }
        },
        "else": {
          "actions": {}
        },
        "runAfter": {
          "assignment-status": [
            "SUCCEEDED",
            "FAILED"
          ]
        }
      }
    },
    "else": {
      "actions": {}
    }
  }
  BODY
}

resource "azurerm_monitor_action_group" "budget_write_alerts_action" {
  name                = "Budget Write Alerts Action"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "budget_wac"

  email_receiver {
    name          = "bibichannel"
    email_address = "trung.khanh150901@gmail.com"
  }

  logic_app_receiver {
    name                    = "logicappaction"
    resource_id             = azurerm_logic_app_workflow.delele_policy_assignemt_workflow.id
    callback_url            = azurerm_logic_app_trigger_http_request.budget_write_alerts_action.callback_url
    use_common_alert_schema = true
  }
}

resource "azurerm_monitor_activity_log_alert" "main" {
  name                = "budget-write-activitylogalert"
  resource_group_name = azurerm_resource_group.this.name
  location            = "global"
  scopes              = [data.azurerm_subscription.current.id]
  description         = "This alert will monitor create and update bugets."

  criteria {
    operation_name = "Microsoft.Consumption/budgets/write"
    category       = "Administrative"
  }

  action {
    action_group_id = azurerm_monitor_action_group.budget_write_alerts_action.id
  }
}