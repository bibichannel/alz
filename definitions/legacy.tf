# # Deny create subcription
module "deny_subscription_creation" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../custom_policy/legacy/deny_subscription_creation.json"
  management_group_id = var.legacy_management_group_id
}
