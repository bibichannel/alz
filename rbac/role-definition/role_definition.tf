locals {
  # Convert scope_map into a map for easier lookup
  scope_map = { for item in var.scope_map : item.key => item.value }

  # Transforming the architype with updated scope and assignable_scopes
  updated_architype = {
    roles = [
      for role in var.architype.roles : {
        name        = role.name
        description = role.description
        scope       = lookup(local.scope_map, role.scope, null) # Update scope
        assignable_scopes = [
          for assignable_scope in role.assignable_scopes : lookup(local.scope_map, assignable_scope, null)
        ]
        permissions = role.permissions
      }
    ]
  }
}

resource "azurerm_role_definition" "custom_roles" {
  for_each = { for role in local.updated_architype.roles : role.name => role }

  name              = each.key
  description       = each.value.description
  scope             = each.value.scope
  assignable_scopes = each.value.assignable_scopes

  permissions {
    actions          = each.value.permissions.actions
    not_actions      = each.value.permissions.not_actions
    data_actions     = each.value.permissions.data_actions
    not_data_actions = each.value.permissions.not_data_actions
  }
}

output "custom_roles" {
  value = azurerm_role_definition.custom_roles
}