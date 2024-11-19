locals {
  architype_intermediate_root = jsondecode(file("${path.module}/archetype_intermediate_root.json"))
  archetype_foundations = jsondecode(file("${path.module}/archetype_foundations.json"))
  archetype_management = jsondecode(file("${path.module}/archetype_management.json"))
  archetype_shared_services = jsondecode(file("${path.module}/archetype_shared_services.json"))
  architype_legacy = jsondecode(file("${path.module}/archetype_legacy.json"))
  archetype_identity = jsondecode(file("${path.module}/archetype_identity.json"))
  architype_connectivity = jsondecode(file("${path.module}/archetype_connectivity.json"))
  archetype_landing_zones = jsondecode(file("${path.module}/archetype_landing_zones.json"))
}

# module "assignment" {
#   source                      = "..//assignment"
#   architype = local.architype_intermediate_root
# }

module "assignment_01" {
  source                      = "..//assignment"
  architype = local.archetype_foundations
}

# module "assignment_management" {
#   source = "..//assignment"
#   architype = local.archetype_management
# }

# module "assignment_shared_services" {
#   source = "..//assignment"
#   architype = local.archetype_shared_services
# }

# module "assignment_legacy" {
#   source = "..//assignment"
#   architype = local.architype_legacy
# }

# module "assignment_identity" {
#   source = "..//assignment"
#   architype = local.archetype_identity
# }

# module "architype_connectivity" {
#   source = "..//assignment"
#   architype = local.architype_connectivity  
# }

module "archetype_landing_zones" {
  source = "..//assignment"
  architype = local.archetype_landing_zones  
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