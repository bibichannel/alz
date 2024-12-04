# Define the list of file names
$fileNames = @(
"dine_alert_management_activitylog_laworkspace_delete.json",
"dine_alert_management_activitylog_laworkspace_key_regen.json",
"dine_alert_management_activitylog_storage_account_delete.json",
"dine_alert_management_aa_total_job_alert.json",
"dine_alert_management_laworkspace_daily_cap_limit_reached_alert.json",
"dine_alert_management_recovery_vault_asr_health_monitor_alert.json",
"dine_alert_management_recovery_vault_backup_health_monitor_alert.json",
"dine_alert_management_storage_account_availability_alert.json"

)

# Create each file in the list
foreach ($fileName in $fileNames) {
    New-Item -Path $fileName -ItemType File -Force
}

Write-Output "All files have been created successfully."
