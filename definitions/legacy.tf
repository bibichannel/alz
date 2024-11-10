# # Deny create subcription
module "deny_create_subscription" {
    source              = "..//modules/definition"
    file_path           = ""
    management_group_id = var.legacy_management_group_id
}