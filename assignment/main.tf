module "builtin_definitions_assignment" {
  for_each = { for idx, def in local.builtin_definitions_updated : idx => def }
  source   = "../modules/def_assignment"

  definition                  = each.value.definition
  assignment_scope            = local.assignment_scope_id
  assignment_name             = lookup(each.value, "assignment_name", null)
  assignment_display_name     = lookup(each.value, "assignment_display_name", null)
  assignment_description      = lookup(each.value, "assignment_description", null)
  assignment_effect           = lookup(each.value, "assignment_effect", null)
  assignment_metadata         = lookup(each.value, "assignment_metadata", null)
  assignment_parameters       = lookup(each.value, "assignment_parameters", {})
  assignment_enforcement_mode = lookup(each.value, "assignment_enforcement_mode", true)
  assignment_location         = lookup(each.value, "assignment_location", "westeurope")
  assignment_not_scopes       = lookup(each.value, "assignment_not_scopes", [])
  failure_percentage          = lookup(each.value, "failure_percentage", null)
  identity_ids                = lookup(each.value, "identity_ids", null)
  location_filters            = lookup(each.value, "location_filters", [])
  non_compliance_message      = lookup(each.value, "non_compliance_message", null)
  parallel_deployments        = lookup(each.value, "parallel_deployments", null)
  re_evaluate_compliance      = lookup(each.value, "re_evaluate_compliance", false)
  remediation_scope           = lookup(each.value, "remediation_scope", null)
  resource_count              = lookup(each.value, "resource_count", null)
  resource_selectors          = lookup(each.value, "resource_selectors", [])
  role_assignment_scope       = lookup(each.value, "role_assignment_scope", null)
  role_definition_ids         = lookup(each.value, "role_definition_ids", [])
  skip_remediation            = lookup(each.value, "skip_remediation", false)
  skip_role_assignment        = lookup(each.value, "skip_role_assignment", false)
}

module "custom_definitions_assignment" {
  for_each = { for idx, def in local.custom_definitions_updated : idx => def }
  source   = "../modules/def_assignment"

  definition                  = each.value.definition
  assignment_scope            = local.assignment_scope_id
  assignment_name             = lookup(each.value, "assignment_name", null)
  assignment_display_name     = lookup(each.value, "assignment_display_name", null)
  assignment_description      = lookup(each.value, "assignment_description", null)
  assignment_effect           = lookup(each.value, "assignment_effect", null)
  assignment_metadata         = lookup(each.value, "assignment_metadata", null)
  assignment_parameters       = lookup(each.value, "assignment_parameters", {})
  assignment_enforcement_mode = lookup(each.value, "assignment_enforcement_mode", true)
  assignment_location         = lookup(each.value, "assignment_location", "westeurope")
  assignment_not_scopes       = lookup(each.value, "assignment_not_scopes", [])
  failure_percentage          = lookup(each.value, "failure_percentage", null)
  identity_ids                = lookup(each.value, "identity_ids", null)
  location_filters            = lookup(each.value, "location_filters", [])
  non_compliance_message      = lookup(each.value, "non_compliance_message", null)
  parallel_deployments        = lookup(each.value, "parallel_deployments", null)
  re_evaluate_compliance      = lookup(each.value, "re_evaluate_compliance", false)
  remediation_scope           = lookup(each.value, "remediation_scope", null)
  resource_count              = lookup(each.value, "resource_count", null)
  resource_selectors          = lookup(each.value, "resource_selectors", [])
  role_assignment_scope       = lookup(each.value, "role_assignment_scope", null)
  role_definition_ids         = lookup(each.value, "role_definition_ids", [])
  skip_remediation            = lookup(each.value, "skip_remediation", false)
  skip_role_assignment        = lookup(each.value, "skip_role_assignment", false)
}

module "builtin_definition_sets_assignment" {
  for_each = { for idx, def in local.builtin_defnition_sets_updated : idx => def }
  source   = "../modules/set_assignment"

  assignment_scope            = local.assignment_scope_id
  initiative                  = each.value.initiative
  assignment_name             = lookup(each.value, "assignment_name", null)
  assignment_display_name     = lookup(each.value, "assignment_display_name", null)
  assignment_description      = lookup(each.value, "assignment_description", null)
  assignment_effect           = lookup(each.value, "assignment_effect", null)
  assignment_metadata         = lookup(each.value, "assignment_metadata", null)
  assignment_parameters       = lookup(each.value, "assignment_parameters", null)
  assignment_enforcement_mode = lookup(each.value, "assignment_enforcement_mode", true)
  assignment_location         = lookup(each.value, "assignment_location", "westeurope")
  assignment_not_scopes       = lookup(each.value, "assignment_not_scopes", [])
  failure_percentage          = lookup(each.value, "failure_percentage", null)
  identity_ids                = lookup(each.value, "identity_ids", null)
  location_filters            = lookup(each.value, "location_filters", [])
  non_compliance_messages     = lookup(each.value, "non_compliance_messages", {})
  overrides                   = lookup(each.value, "overrides", [])
  parallel_deployments        = lookup(each.value, "parallel_deployments", null)
  re_evaluate_compliance      = lookup(each.value, "re_evaluate_compliance", false)
  remediation_scope           = lookup(each.value, "remediation_scope", null)
  resource_count              = lookup(each.value, "resource_count", null)
  resource_selectors          = lookup(each.value, "resource_selectors", [])
  role_assignment_scope       = lookup(each.value, "role_assignment_scope", null)
  role_definition_ids         = lookup(each.value, "role_definition_ids", [])
  skip_remediation            = lookup(each.value, "skip_remediation", false)
  skip_role_assignment        = lookup(each.value, "skip_role_assignment", false)
}


module "custom_definition_sets_assignment" {
  for_each = { for idx, def in local.custom_defnition_sets_updated : idx => def }
  source   = "../modules/set_assignment"

  assignment_scope            = local.assignment_scope_id
  initiative                  = each.value.initiative
  assignment_name             = lookup(each.value, "assignment_name", null)
  assignment_display_name     = lookup(each.value, "assignment_display_name", null)
  assignment_description      = lookup(each.value, "assignment_description", null)
  assignment_effect           = lookup(each.value, "assignment_effect", null)
  assignment_metadata         = lookup(each.value, "assignment_metadata", null)
  assignment_parameters       = lookup(each.value, "assignment_parameters", null)
  assignment_enforcement_mode = lookup(each.value, "assignment_enforcement_mode", true)
  assignment_location         = lookup(each.value, "assignment_location", "westeurope")
  assignment_not_scopes       = lookup(each.value, "assignment_not_scopes", [])
  failure_percentage          = lookup(each.value, "failure_percentage", null)
  identity_ids                = lookup(each.value, "identity_ids", null)
  location_filters            = lookup(each.value, "location_filters", [])
  non_compliance_messages     = lookup(each.value, "non_compliance_messages", {})
  overrides                   = lookup(each.value, "overrides", [])
  parallel_deployments        = lookup(each.value, "parallel_deployments", null)
  re_evaluate_compliance      = lookup(each.value, "re_evaluate_compliance", false)
  remediation_scope           = lookup(each.value, "remediation_scope", null)
  resource_count              = lookup(each.value, "resource_count", null)
  resource_selectors          = lookup(each.value, "resource_selectors", [])
  role_assignment_scope       = lookup(each.value, "role_assignment_scope", null)
  role_definition_ids         = lookup(each.value, "role_definition_ids", [])
  skip_remediation            = lookup(each.value, "skip_remediation", false)
  skip_role_assignment        = lookup(each.value, "skip_role_assignment", false)
}