output "custom_roles" {
  value = module.role_definition.custom_roles
}

output "role_assignments" {
  value = module.role_assignments.role_assignments
}

output "azuread_groups" {
  value = module.role_assignments.azuread_groups
}