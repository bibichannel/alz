
# # https://www.azadvertizer.net/azpolicyinitiativesadvertizer/Deploy-AUM-CheckUpdates.html
# locals {
#   modify_aum_check_updates_policy_ids = {
#     "arc_servers_periodic_update_check"      = "bfea026e-043f-4ff4-9d1b-bf301ca7ff46",
#     "virtual_machines_periodic_update_check" = "59efceea-0c96-497e-a4a1-4eb2290dac15",
#   }
# }

# data "azurerm_policy_definition" "modify_aum_check_updates_policy_definitions" {
#   for_each = local.modify_aum_check_updates_policy_ids
#   name     = each.value
# }

# module "modify_aum_check_updates" {
#   source                  = "..//modules/initiative"
#   initiative_name         = "modify_aum_check_updates"
#   initiative_display_name = "Configure periodic checking for missing system updates on azure virtual machines and Arc-enabled virtual machines"
#   initiative_description  = "Configure auto-assessment (every 24 hours) for OS updates. You can control the scope of assignment according to machine subscription, resource group, location or tag. Learn more about this for Windows: https://aka.ms/computevm-windowspatchassessmentmode, for Linux: https://aka.ms/computevm-linuxpatchassessmentmode."
#   initiative_category     = "Security Center"
#   management_group_id     = var.foundations_management_group_id
#   merge_effects           = true
#   merge_parameters        = false
#   initiative_version      = "1.0.0"
#   member_definitions = [
#     for definition in data.azurerm_policy_definition.modify_aum_check_updates_policy_definitions : definition
#   ]
# }

# module "enforce_tag_specification" {
#   source = "..//modules/initiative"
#   initiative_name         = "enforce_tag_specification"
#   initiative_display_name = "Enforce tag according to specific requirements"
#   initiative_description  = "Enforce tag according to specific requirements"
#   initiative_category     = "Tag Governance"
#   management_group_id     = var.foundations_management_group_id
#   member_definitions = [

#   ]
# }

