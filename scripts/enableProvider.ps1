function CheckModules($module) {
    $installedModule = Get-InstalledModule -Name $module -ErrorAction SilentlyContinue
    if ($null -eq $installedModule) {
        Write-Warning "The $module PowerShell module is not found."
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

function Enable-AzResourceProvider {
    param (
        [Parameter(Mandatory = $true)]
        [string]$resourceProviderName
    )

    # Check if the $resourceProviderName is a valid Azure Resource Provider
    $validProviders = Get-AzResourceProvider
    if (-not ($validProviders.ProviderNamespace -contains $resourceProviderName)) {
        Write-Error "Invalid resource provider: $resourceProviderName"
        exit
    }

    # Verify if the resource provider is already registered
    try {
        $provider = Get-AzResourceProvider -ProviderNamespace $resourceProviderName

        if ($provider.RegistrationState -eq 'Registered') {
            Write-Host "$resourceProviderName is already registered."
            return  # Exit the function early if it's already registered
        } else {
            Write-Host "$resourceProviderName is not registered. Registering it now..."
            
            # Enable the resource provider
            Register-AzResourceProvider -ProviderNamespace $resourceProviderName
        }
    }
    catch {
        Write-Error "Error checking or registering resource provider: $_"
        exit  # Exit on error while checking or registering the provider
    }

    # Wait for the registration to complete
    Write-Host "Waiting for registration to complete..."
    Start-Sleep -Seconds 60

    $maxRetries = 4
    $retryCount = 0
    $success = $false

    while ($retryCount -lt $maxRetries -and !$success) {
        try {
            # Verify if the resource provider has been registered
            $provider = Get-AzResourceProvider -ProviderNamespace $resourceProviderName
            
            if ($provider.RegistrationState -eq 'Registered') {
                Write-Host "$resourceProviderName has been successfully registered."
                $success = $true  # Exit the loop as registration is successful
            } elseif ($provider.RegistrationState -eq 'Registering') {
                Write-Host "$resourceProviderName is currently being registered. Waiting for completion."
            } else {
                Write-Host "$resourceProviderName is not yet registered."
                $retryCount++
                
                if ($retryCount -lt $maxRetries) {
                    Write-Host "Retrying... ($retryCount/$maxRetries)"
                    Start-Sleep -Seconds 30  # Wait 30 seconds before retrying
                }
            }
        }
        catch {
            Write-Error "Error verifying resource provider status: $_"
            break  # Exit loop on error
        }
    }

    if (!$success) {
        Write-Error "Failed to register $resourceProviderName after $maxRetries attempts."
        exit
    }
}

Enable-AzResourceProvider -resourceProviderName "Microsoft.OperationsManagement"
Enable-AzResourceProvider -resourceProviderName "Microsoft.SecurityInsights"