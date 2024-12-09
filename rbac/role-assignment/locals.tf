# locals {
#   role_assignments = [
#     for item in local.matrix : {
#       description        = item.description
#       group              = item.group
#       role               = item.role
#       scope              = item.scope
#       type               = item.type
#       principal_id      = data.azuread_group.${item.group}.object_id  # Assuming you're using Azure AD Groups
#       principal_type    = "Group"
#       role_definition_id = module.role_assignments.role_definitions[item.role].id
#     }
#   ]
# }
