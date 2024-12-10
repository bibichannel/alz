output "custom_roles" {
  value = module.role_definition.custom_roles
}

output "matrix" {
  value = local.matrix
}

output "role_assignments" {
  value = module.role_assignments.role_assignments
}