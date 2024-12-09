# map(object({
#     role_definition_id_or_name             = string
#     principal_id                           = string
#     description                            = optional(string, null)
#     skip_service_principal_aad_check       = optional(bool, false)
#     condition                              = optional(string, null)
#     condition_version                      = optional(string, null)
#     delegated_managed_identity_resource_id = optional(string, null)
#   }))

variable "role_aasignment_matrix" {
  type = any
}

variable "role_definitions" {
  type = map(object({
    id    = optional(string)
    name  = optional(string)
    scope = optional(string)
  }))
  default     = {}
  nullable    = false
  description = <<DESCRIPTION
(Optional) A map of Azure Resource Manager role definitions to reference in role assignments.
The key is something unique to you. The value is a built in or custom role definition name.

Example Input:

```hcl
role_definitions = {
  owner = {
    name = "Owner"
  }
  contributor = {
    name = "Contributor"
  }
  reader = {
    name = "Reader"
  }
  custom_role_by_name = {
    name  = "Custom Role"
    scope = "/subscriptions/00000000-0000-0000-0000-000000000000"
  }
  custom_role_by_id = {
    id = "00000000-0000-0000-0000-000000000000"
  }
}
```
DESCRIPTION
}
