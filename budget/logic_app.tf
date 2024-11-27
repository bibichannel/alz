resource "azurerm_resource_group" "this" {
  name     = "workflow-resources"
  location = "East US"
}

resource "azurerm_logic_app_workflow" "budget-workflow" {
  name                = "budget-workflow"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
  depends_on = [azurerm_user_assigned_identity.this]
}

resource "azurerm_logic_app_trigger_http_request" "trigger" {
  name         = "workflow-trigger"
  logic_app_id = azurerm_logic_app_workflow.budget-workflow.id
  schema       = data.local_file.trigger.content
}

resource "azurerm_logic_app_action_custom" "assignment_checking" {
  name         = "assignment_checking"
  logic_app_id = azurerm_logic_app_workflow.budget-workflow.id
  body = <<BODY
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

resource "azurerm_logic_app_action_custom" "conditions" {
  name         = "conditions"
  logic_app_id = azurerm_logic_app_workflow.budget-workflow.id
  body = <<BODY
  {
    "runAfter": {
      "${azurerm_logic_app_action_custom.assignment_checking.name}": [
        "SUCCEEDED",
        "FAILED"
      ]
    },
    "type": "If",
    "expression": {
      "and": [
        {
          "equals": [
            "@outputs('${azurerm_logic_app_action_custom.assignment_checking.name}')?['statusCode']",
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

# resource "azurerm_resource_group_template_deployment" "manage-budget" {
#   resource_group_name = azurerm_resource_group.this.name
#   deployment_mode     = "Incremental"
#   name                = "logic-app-manage-budget"

#   template_content = data.local_file.logic_app.content

#   parameters_content = jsonencode({
#     "logic_app_name" = { value = azurerm_logic_app_workflow.budget-workflow.name }
#     "location"       = { value = azurerm_logic_app_workflow.budget-workflow.location }
#     "identity_id"    = { value = azurerm_user_assigned_identity.this.id }
#   })

#   depends_on = [azurerm_logic_app_workflow.budget-workflow]
# }


