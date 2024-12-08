param(
    [Parameter(Mandatory=$true)]
    [string]$ClientId,

    [Parameter(Mandatory=$true)]
    [string]$Secret,

    [Parameter(Mandatory=$true)]
    [string]$TenantId,

    [Parameter(Mandatory=$true)]
    [string]$WorkingDirectory
)

function Read-ConfigData {
    param (
        [string]$ConfigPath
    )
    if (-not (Test-Path $ConfigPath)) {
        Write-Error "Config file not found at: $ConfigPath"
        return $null
    }
    $configContent = Get-Content -Path $ConfigPath -Raw
    $config = $configContent | ConvertFrom-Json

    return $config
}

$configPath = $WorkingDirectory + "config.json"
$configData = Read-ConfigData -ConfigPath $configPath

if ($configData -eq $null) {
    Write-Error "Failed to read config data. Exiting..."
    exit
}



$enableRules = 'Yes'

$Connectors_rule = @('azureactivedirectory','microsoft365defender', 'azureactivity')

function CheckModules($module) {
    $installedModule = Get-InstalledModule -Name $module -ErrorAction SilentlyContinue
    if ($null -eq $installedModule) {
        Write-Warning "The $module PowerShell module is not found"
        #check for Admin Privleges
        $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())

        if (-not ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))) {
            #Not an Admin, install to current user
            Write-Warning -Message "Can not install the $module module. You are not running as Administrator"
            Write-Warning -Message "Installing $module module to current user Scope"
            Install-Module -Name $module -Scope CurrentUser -Force
            Import-Module -Name $module -Force
        }
        else {
            #Admin, install to all users
            Write-Warning -Message "Installing the $module module to all users"
            Install-Module -Name $module -Force
            Import-Module -Name $module -Force
        }
    }
    #Install-Module will obtain the module from the gallery and install it on your local machine, making it available for use.
    #Import-Module will bring the module and its functions into your current powershell session, if the module is installed.  
}

CheckModules("Az.Resources")
CheckModules("Az.OperationalInsights")
CheckModules("Az.SecurityInsights")
CheckModules("Az.MonitoringSolutions")
CheckModules("Az.Monitor")

$SecuredPassword = ConvertTo-SecureString $Secret -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ClientId, $SecuredPassword
Connect-AzAccount -ServicePrincipal -TenantId $TenantId, -Credential $Credential
$subscriptions = Get-AzSubscription

$foundSubscription = $false

foreach ($subscription in $subscriptions) {
    # Set the context to the current subscription
    Set-AzContext -SubscriptionId $subscription.Id
    $context = Get-AzContext

    $SubscriptionId = $subscription.Id

    foreach ($con in $configData.Subscriptions) {
        if ($con.SubscriptionId -eq $subscriptionId) {
            $ResourceGroup = $con.ResourceGroup
            $Workspace = $con.Workspace
            $Location = $con.Location
            $foundSubscription = $true
            break
        }
    }
    if (-not $foundSubscription) {
        continue
    }
    
    $ResourceGroup = $ResourceGroup -replace '[^A-Za-z0-9-]', '-'
    $Workspace = $Workspace -replace '[^A-Za-z0-9-]', '-'

    Write-Host "Resource Group: $ResourceGroup"
    Write-Host "Workspace: $Workspace"
    Write-Host "Location: $Location"


    $ConnectorsFile = $WorkingDirectory + "connectors.json"
    # Attempt to get the resource group
    Get-AzResourceGroup -Name $ResourceGroup -ErrorVariable notPresent -ErrorAction SilentlyContinue

    if ($notPresent){
        Write-Host "Creating resource group $ResourceGroup in region $Location..."
        New-AzResourceGroup -Name $ResourceGroup -Location $Location
    }
    else{
        Write-Host "Resource Group $ResourceGroup already exists. Skipping..."
    }

    $attemptLimit = 5
    $attempts = 0
    $success = $false

    #Create Log Analytics workspace
    while (-not $success -and $attempts -lt $attemptLimit) {
        try {

            $WorkspaceObject = Get-AzOperationalInsightsWorkspace -Name $Workspace -ResourceGroupName $ResourceGroup  -ErrorAction Stop
            $ExistingLocation = $WorkspaceObject.Location
            $WorkspaceID = $WorkspaceObject.CustomerId
            Write-Output "Workspace named $Workspace in region $ExistingLocation already exists. Skipping..."

        } catch {

            Write-Output "Creating new workspace named $Workspace in region $Location..."
            # Create the new workspace for the given name, region, and resource group
            $WorkspaceObject = New-AzOperationalInsightsWorkspace -Location $Location -Name $Workspace -Sku pergb2018 -ResourceGroupName $ResourceGroup
            $WorkspaceID = $WorkspaceObject.CustomerId
        }

        $solutions = Get-AzOperationalInsightsIntelligencePack -resourcegroupname $ResourceGroup -WorkspaceName $Workspace -WarningAction:SilentlyContinue

        if (($solutions | Where-Object Name -eq 'SecurityInsights').Enabled) {
            Write-Host "Azure Sentinel is already installed on workspace $($Workspace)"
        }
        else {    
            New-AzMonitorLogAnalyticsSolution -Type SecurityInsights -ResourceGroupName $ResourceGroup -Location $Location -WorkspaceResourceId $WorkspaceObject.ResourceId
        }

        try {
            $attempts++
            Write-Host "Trying to get Azure Sentinel Alert Rule Templates..."
            $msTemplates = Get-AzSentinelAlertRuleTemplate -WorkspaceName $Workspace -ResourceGroupName $ResourceGroup | Where-Object Kind -EQ MicrosoftSecurityIncidentCreation
            $success = $true
        } catch {
            if ($_.Exception.Message -match "is not onboarded to Microsoft Sentinel") {
                Write-Host "Workspace '$Workspace' is not onboarded to Microsoft Sentinel. Retrying in 30 seconds..."
                Start-Sleep -Seconds 30
            } else {
                Write-Host "An unexpected error occurred: $($_.Exception.Message)"
                break 
            }
        }
    }

    #Urls to be used for Sentinel API calls
    $baseUri = "/subscriptions/${SubscriptionId}/resourceGroups/${ResourceGroup}/providers/Microsoft.OperationalInsights/workspaces/${Workspace}"
    $connectedDataConnectorsUri = "$baseUri/providers/Microsoft.SecurityInsights/dataConnectors/?api-version=2020-08-01"

    function Get-ConnectedDataconnectors{
        try {
                $allConnectedDataconnectors = (Invoke-AzRestMethod -Path $connectedDataConnectorsUri -Method GET).Content | ConvertFrom-Json			
            }
        catch {
            $errorReturn = $_
            Write-Error "Unable to invoke webrequest with error message: $errorReturn" -ErrorAction Stop
        }
        return $allConnectedDataconnectors
    }

    function checkDataConnector($dataConnector){
        $currentDataconnector = "" | Select-Object -Property guid,etag,isEnabled
        if ($allConnectedDataconnectors.value.Length -ne 0){
            foreach ($value in $allConnectedDataconnectors.value){			
                if ($value.kind -eq $dataConnector) {
                    Write-Host "Successfully queried data connector $($value.kind) - already enabled"
                    Write-Verbose $value
                    
                    $currentDataconnector.guid = $value.name
                    $currentDataconnector.etag = $value.etag
                    $currentDataconnector.isEnabled = $true
                    break					
                }
            }
            if ($currentDataconnector.isEnabled -ne $true)
            {
                $currentDataconnector.guid = (New-Guid).Guid
                $currentDataconnector.etag = $null
                $currentDataconnector.isEnabled = $false
            }
        }
        else{        
            $currentDataconnector.guid = (New-Guid).Guid
            $currentDataconnector.etag = $null
            $currentDataconnector.isEnabled = $false
        }
        return $currentDataconnector
    }

    function BuildDataconnectorPayload($dataConnector, $guid, $etag, $isEnabled){    
        if ($dataConnector.kind -ne "AzureSecurityCenter")
        {
            $connectorProperties = $dataConnector.properties
            $connectorProperties | Add-Member -NotePropertyName tenantId -NotePropertyValue ${context}.Tenant.Id
        }
        else {
            $connectorProperties = $dataConnector.properties
            $connectorProperties | Add-Member -NotePropertyName subscriptionId -NotePropertyValue ${context}.Subscription.Id
        }	
        
        if ($isEnabled) {
            # Compose body for connector update scenario
            Write-Host "Updating data connector $($dataConnector.kind)"
            Write-Verbose "Name: $guid"
            Write-Verbose "Etag: $etag"
            
            $connectorBody = @{}

            $connectorBody | Add-Member -NotePropertyName kind -NotePropertyValue $dataConnector.kind -Force
            $connectorBody | Add-Member -NotePropertyName name -NotePropertyValue $guid -Force
            $connectorBody | Add-Member -NotePropertyName etag -NotePropertyValue $etag -Force
            $connectorBody | Add-Member -NotePropertyName properties -NotePropertyValue $connectorProperties
        }
        else {
            # Compose body for connector enable scenario
            Write-Host "$($dataConnector.kind) data connector is not enabled yet"
            Write-Host "Enabling data connector $($dataConnector.kind)"
            Write-Verbose "Name: $guid"
            
            $connectorBody = @{}

            $connectorBody | Add-Member -NotePropertyName kind -NotePropertyValue $dataConnector.kind -Force
            $connectorBody | Add-Member -NotePropertyName properties -NotePropertyValue $connectorProperties

        }
        return $connectorBody
    }

    function EnableOrUpdateDataconnector($baseUri, $guid, $connectorBody, $isEnabled){ 
        $uri = "${baseUri}/providers/Microsoft.SecurityInsights/dataConnectors/${guid}?api-version=2023-08-01-preview"
        try {
            $result = Invoke-AzRestMethod -Path $uri -Method PUT -Payload ($connectorBody | ConvertTo-Json -Depth 3)
            if ($result.StatusCode -eq 200) {
                if ($isEnabled){
                    Write-Host "Successfully updated data connector: $($connector.kind)" -ForegroundColor Green
                }
                else {
                    Write-Host "Successfully enabled data connector: $($connector.kind)" -ForegroundColor Green
                }
            }
            else {
                Write-Error "Unable to enable data connector $($connector.kind) with error: $($result.Content)" 
            }
            Write-Host ($body.Properties | Format-List | Format-Table | Out-String)
        }
        catch {
            $errorReturn = $_
            Write-Verbose $_
            Write-Error "Unable to invoke webrequest with error message: $errorReturn" -ErrorAction Stop
        }
    }

    function EnableMSAnalyticsRule($msProduct){ 
        try {
            foreach ($rule in $msTemplates){
                if ($rule.productFilter -eq $msProduct) {
                    New-AzSentinelAlertRule -ResourceGroupName $ResourceGroup -WorkspaceName $Workspace -DisplayName $rule.displayName -MicrosoftSecurityIncidentCreation -Description $rule.description -ProductFilter $msProduct                
                    Write-Host "Done!" -ForegroundColor Green
                }
            }
        }
        catch {
            $errorReturn = $_
            Write-Verbose $_
            Write-Error "Unable to create analytics rule with error message: $errorReturn" -ErrorAction Stop
        }
    }

    $connectors = Get-Content -Raw -Path $ConnectorsFile | ConvertFrom-Json

    #Getting all connected Data connectors
    $allConnectedDataconnectors = Get-ConnectedDataconnectors

    foreach ($connector in $connectors.connectors) {
        Write-Host "`r`nProcessing connector: " -NoNewline 
        Write-Host "$($connector.kind)" -ForegroundColor Blue

        #AzureActivityLog connector
        if ($connector.kind -eq "AzureActivityLog") {
            $SubNoHyphens = $SubscriptionId -replace '-',''
            $uri = "$baseUri/datasources/${SubNoHyphens}?api-version=2015-11-01-preview"
            $connectorBody = ""
            $activityEnabled = $false

            #Check if AzureActivityLog is already connected (there is no better way yet) [assuming there is only one AzureActivityLog from same subscription connected]
            try {
                $diagnosticSettingName = "AzureActivityLogToSentinel"
                # AzureActivityLog is already connected, compose body with existing etag for update
                $workspacazure = Get-AzOperationalInsightsWorkspace -ResourceGroupName $resourceGroup -Name $Workspace
                $workspaceResourceId = $workspacazure.ResourceId

                $subscriptionResourceId = "/subscriptions/$subscriptionId"

                $logsToEnable = @(
                    @{category = "Administrative"; enabled = $true},
                    @{category = "Security"; enabled = $true},
                    @{category = "ServiceHealth"; enabled = $true},
                    @{category = "Alert"; enabled = $true},
                    @{category = "Recommendation"; enabled = $true},
                    @{category = "Policy"; enabled = $true},
                    @{category = "Autoscale"; enabled = $true},
                    @{category = "ResourceHealth"; enabled = $true}
                )

                $result = New-AzDiagnosticSetting -ResourceId $subscriptionResourceId `
                    -WorkspaceId $workspaceResourceId `
                    -Name $diagnosticSettingName `
                    -Log $logsToEnable 

                if ($result) {
                    Write-Host "Successfully enabled or updated data connector:  Azure Activity Log" -ForegroundColor Green 
                } else {
                    Write-Host "Failed to enable data connector for Azure Activity Log for the subscription: $subscriptionId" -ForegroundColor Red
                }
            }
            catch {
                $errorReturn = $_
                Write-Verbose $_.Exception.Message
                Write-Error "Unable to invoke webrequest with error message: $errorReturn" -ErrorAction Stop
            }  
        }

        #Office365 connector
        elseif ($connector.kind -eq "Office365") {
            $dataConnectorBody = ""        
            #query for connected Data connectors
            $connectorProperties = checkDataConnector($connector.kind)
            $dataConnectorBody = BuildDataconnectorPayload $connector $connectorProperties.guid $connectorProperties.etag $connectorProperties.isEnabled
            EnableOrUpdateDataconnector $baseUri $connectorProperties.guid $dataConnectorBody $connectorProperties.isEnabled
        }
        AzureActiveDirectory
        elseif ($connector.kind -eq "AzureActiveDirectoryDiagnostics") {
            <# Azure Active Directory Audit/SignIn logs - requires special call and is therefore not connectors file#>
            $uri = "/providers/microsoft.aadiam/diagnosticSettings/AzureSentinel_${Workspace}?api-version=2017-04-01"
            
            $connectorProperties = $connector.properties
            $connectorProperties | Add-Member -NotePropertyName workspaceId -NotePropertyValue "/subscriptions/${SubscriptionId}/resourcegroups/${ResourceGroup}/providers/Microsoft.OperationalInsights/workspaces/${Workspace}"

            $connectorBody = @{}

            $connectorBody | Add-Member -NotePropertyName name -NotePropertyValue "AzureSentinel_${Workspace}"
            $connectorBody.Add("properties",$connectorProperties)
            
                
            try {
                $result = Invoke-AzRestMethod -Path $uri -Method PUT -Payload ($connectorBody | ConvertTo-Json -Depth 3)
                if ($result.StatusCode -eq 200) {
                    Write-Host "Successfully enabled data connector: $($connector.kind)" -ForegroundColor Green
                }
                else {
                    Write-Error "Unable to enable data connector $($connector.kind) with error: $($result.Content)" 
                }
                Write-Verbose ($body.Properties | Format-List | Format-Table | Out-String)
            }
            catch {
                Write-Error "Error in making API call: $_" -ErrorAction Stop
            }
        }
        #Microsoft Defender for Endpoint connector
        elseif ($connector.kind -eq "MicrosoftDefenderAdvancedThreatProtection") {
            $dataConnectorBody = ""        
            #query for connected Data connectors
            $connectorProperties = checkDataConnector($connector.kind)
            $dataConnectorBody = BuildDataconnectorPayload $connector $connectorProperties.guid $connectorProperties.etag $connectorProperties.isEnabled
            EnableOrUpdateDataconnector $baseUri $connectorProperties.guid $dataConnectorBody $connectorProperties.isEnabled
            Write-Host "Adding Analytics Rule for data connector Microsoft Defender XDR..." -NoNewline
            EnableMSAnalyticsRule "Microsoft Defender for Endpoint"
        }  
        
    }
}