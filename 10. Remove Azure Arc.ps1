# Uninstall the Azure Connected Machine agent
$agentService = Get-Service -Name himds -ErrorAction SilentlyContinue
if ($agentService) {
    Stop-Service -Name himds -Force
    $agentUninstallPath = "${env:ProgramFiles}\AzureConnectedMachineAgent\azcmagent.exe"
    if (Test-Path $agentUninstallPath) {
        Start-Process -FilePath $agentUninstallPath -ArgumentList "disconnect" -Wait
        Start-Process -FilePath $agentUninstallPath -ArgumentList "uninstall" -Wait
    } else {
        Write-Warning "Azure Connected Machine Agent not found at the default location."
    }
} else {
    Write-Warning "Azure Connected Machine Agent service (himds) not found."
}

# Remove any remaining Azure Arc-related files and directories
$arcDirectories = @(
    "${env:ProgramFiles}\AzureConnectedMachineAgent",
    "${env:ProgramData}\AzureConnectedMachineAgent"
)
foreach ($dir in $arcDirectories) {
    if (Test-Path $dir) {
        Remove-Item -Path $dir -Recurse -Force
    }
}

# Clean up registry entries (optional, use with caution)
$arcRegistryPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Azure Connected Machine Agent",
    "HKLM:\SOFTWARE\Microsoft\HybridCompute",
    "HKLM:\SOFTWARE\Microsoft\Azure ARC"
)
foreach ($regPath in $arcRegistryPaths) {
    if (Test-Path $regPath) {
        Remove-Item -Path $regPath -Recurse -Force
    }
}

# Restart the server to ensure all changes take effect
Write-Host "Azure Arc has been removed. Restarting the server..."
Restart-Computer -Force