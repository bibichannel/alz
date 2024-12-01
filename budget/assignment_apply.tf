
resource "azurerm_logic_app_workflow" "assign_policy_assignemt_workflow" {
  depends_on          = [azurerm_user_assigned_identity.this]
  name                = "assign-policy-assignemt-workflow"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
}

resource "azurerm_logic_app_trigger_http_request" "budget_threshold_alert" {
  name         = "budget-threshold-alert"
  logic_app_id = azurerm_logic_app_workflow.assign_policy_assignemt_workflow.id
  schema       = data.local_file.trigger.content
}

resource "azurerm_logic_app_action_custom" "policy_assignment_status" {
  name         = "policy-assignment-status"
  logic_app_id = azurerm_logic_app_workflow.assign_policy_assignemt_workflow.id
  body         = <<BODY
  {
    "runAfter": {},
    "type": "Http",
    "inputs": {
      "uri": "https://management.azure.com/@{triggerBody()?['data']?['alertContext']['AlertData']['Scope']}/providers/Microsoft.Authorization/policyAssignments/testingassignment?api-version=2023-04-01",
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

resource "azurerm_logic_app_action_custom" "policy_assignment_status_conditions" {
  name         = "policy-assignment-status-conditions"
  logic_app_id = azurerm_logic_app_workflow.assign_policy_assignemt_workflow.id
  body         = <<BODY
  {
    "runAfter": {
      "${azurerm_logic_app_action_custom.policy_assignment_status.name}": [
        "SUCCEEDED",
        "FAILED"
      ]
    },
    "type": "If",
    "expression": {
      "and": [
        {
          "equals": [
            "@outputs('${azurerm_logic_app_action_custom.policy_assignment_status.name}')?['statusCode']",
            200
          ]
        }
      ]
    },
    "actions": {},
    "else": {
      "actions": {
        "HTTP_1": {
          "type": "Http",
          "inputs": {
            "uri": "https://management.azure.com/@{triggerBody()?['data']?['alertContext']['AlertData']['Scope']}/providers/Microsoft.Authorization/policyAssignments/testingassignment?api-version=2023-04-01",
            "method": "PUT",
            "body": {
              "properties": {
                "displayName": "Temporary deny create resources",
                "description": "This is policy for testing",
                "metadata": {
                  "assignedBy": "Logic app"
                },
                "policyDefinitionId": "${var.policy_definition_id}",
                "parameters": {
                  "listOfResourceTypesAllowed": {
                    "value": []
                  }
                },
                "nonComplianceMessages": [
                  {
                    "message": "The resources non-compliance."
                  }
                ]
              }
            },
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
      }
    }
  }
  BODY
}

resource "azurerm_monitor_action_group" "budget_threshold_alerts_action" {
  name                = "Budget Threshold Alerts Action"
  resource_group_name = azurerm_resource_group.this.name
  short_name          = "budget_ac"

  email_receiver {
    name          = "bibichannel"
    email_address = "trung.khanh150901@gmail.com"
  }

  logic_app_receiver {
    name                    = "logicappaction"
    resource_id             = azurerm_logic_app_workflow.assign_policy_assignemt_workflow.id
    callback_url            = azurerm_logic_app_trigger_http_request.budget_threshold_alert.callback_url
    use_common_alert_schema = true
  }
}