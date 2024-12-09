# variable "role_assignments_for_management_groups" {
#   type = map(object({
#     management_group_id           = optional(string, null)
#     management_group_display_name = optional(string, null)
#     role_assignments = map(object({
#       role_definition = string
#       groups          = optional(set(string), [])
#     }))
#   }))
#   default     = {}
#   nullable    = false
#   description = <<DESCRIPTION
# (Optional) Role assignments to be applied to management groups.
# This is a convenience variable that avoids the need to find the resource id of the management group.

# - management_group_id: (Optional) The id of the management group (one of `management_group_id` or `management_group_display_name` must be supplied).
# - management_group_display_name: (Optional) The display name of the management group.
# - role_assignments: (Required) The role assignments to be applied to the scope.
#   - role_definition: (Required) The key of the role definition as defined in the `role_definitions` variable.
#   - groups: (Optional) The keys of the groups as defined in one of the `groups_by_...` variables.
 
# Example Input:

# ```hcl
# role_assignments_for_management_groups = {
#   management_group_id = "mg-1-id"
#   role_assignments    = {
#     role_definition = "contributor"
#     groups = [
#       "my-group-1",
#       "my-group-2"
#     ]
#   }
# }

# role_assignments_for_management_groups = {
#   management_group_display_name = "mg-1-display-name"
#   role_assignments              = {
#     role_definition = "contributor"
#     groups = [
#       "my-group-1",
#       "my-group-2"
#     ]
#   }
# }
# ```
# DESCRIPTION
# }