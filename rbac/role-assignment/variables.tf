variable "role_aasignment_at_mg_matrix" {
  type = any
}

variable "role_aasignment_at_sub_matrix" {
  type = any
}

variable "role_aasignment_at_rg_matrix" {
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
