# locals {
#     admin_protection_policies = tolist(fileset("${path.module}/policies/", "*-AdminProtection-*.json"))
#     base_protection_policies = tolist(fileset("${path.module}/policies/", "*-BaseProtection-*.json"))
#     attack_surface_reduction = tolist(fileset("${path.module}/policies/", "*-AttackSurfaceReduction-*.json"))
# }


# locals {
#   admin_protection_policies_dataset = {
#     for filename in local.admin_protection_policies :
#     filename => jsondecode(file("${path.module}/policies/${filename}"))
#   }

#   base_protection_policies_dataset = {
#     for filename in local.base_protection_policies :
#     filename => jsondecode(file("${path.module}/policies/${filename}"))
#   }

#   attack_surface_reduction_dataset = {
#     for filename in local.attack_surface_reduction :
#     filename => jsondecode(file("${path.module}/policies/${filename}"))
#   }
# }


# locals {
#  base_archetype_definitions = merge(
#     local.admin_protection_policies_dataset,
#     local.base_protection_policies_dataset,
#     local.attack_surface_reduction_dataset,
#   )
# }

# output "base_archetype_definitions" {
#   value = local.base_archetype_definitions
# }