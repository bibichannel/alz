locals {
  architype_intermediate_root = jsondecode(file("${path.module}/archetype_intermediate_root.json"))
  archetype_foundations = jsondecode(file("${path.module}/archetype_foundations.json"))
}

# module "assignment" {
#   source                      = "..//assignment"
#   architype = local.architype_intermediate_root
# }

module "assignment_01" {
  source                      = "..//assignment"
  architype = local.archetype_foundations
}

# output "builtin_definitions_updated" {
#   value = module.assignment.builtin_definitions_updated
# }

# output "custom_definitions_updated" {
#   value = module.assignment.custom_definitions_updated
# }

# output "builtin_defnition_sets_updated" {
#   value = module.assignment.builtin_defnition_sets_updated
# }

# output "custom_defnition_sets_updated" {
#   value = module.assignment.custom_defnition_sets_updated
# }