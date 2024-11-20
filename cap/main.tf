module "CAP100-AdminProtection-AllApps-AnyPlatforms-MFAandCompliant" {
  source = "./AdminProtection/100"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = ["<CAP-Admins>"]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP101-AdminProtection-AllApps-AnyPlatforms-Block-FromOtherDevices" {
  source = "./AdminProtection/101"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = ["<CAP-Admins>"]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP110-AdminProtection-AllApps-AnyPlatforms-MFA-BreakGlassAccount" {
  source = "./AdminProtection/110"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = ["<CAP-BreakGlassAccounts>"]
  excluded_groups = [""]
}

module "CAP200-BaseProtection-AllApps-AnyPlatforms-MFAorCompliant" {
  source = "./BaseProtection/200"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP201-BaseProtection-AllApps-AnyPlatforms-MFAorCompliant-RegisterSecurityInfo" {
  source = "./BaseProtection/201"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP202-BaseProtection-AllApps-AnyPlatforms-Block-NonCompliantDevice" {
  source = "./BaseProtection/202"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP211-BasedProtection-AllApps-AnyPlatforms-MFA-RegisterOrJoinEntraIdDevice" {
  source = "./BaseProtection/211"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP300-AttackSurfaceReduction-AllApps-AnyPlatfomrs-Block-UsingOtherClients" {
  source = "./AttackSurfaceReduction/300"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP301-AttackSurfaceReduction-AllApps-AnyPlatfomrs-Block-ActiveSync" {
  source = "./AttackSurfaceReduction/301"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP306-AttackSurfaceReduction-AllApps-AnyPlatfomrs-Block-AuthenticationTransfer" {
  source = "./AttackSurfaceReduction/306"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}

module "CAP307-AttackSurfaceReduction-AllApps-AnyPlatfomrs-Block-DeviceCodeFlow" {
  source = "./AttackSurfaceReduction/307"
  cap_state = "enabledForReportingButNotEnforced"
  included_groups = [""]
  excluded_groups = ["<CAP-BreakGlassAccounts>", "<CAP-ServiceAccounts>"]
}