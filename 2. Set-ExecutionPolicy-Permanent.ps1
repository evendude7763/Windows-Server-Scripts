# Admin check
$adminCheck = [System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()
$adminRole = [System.Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $adminCheck.IsInRole($adminRole)) {
    Write-Host "This script requires administrative privileges. Restarting as admin..."
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Set Execution Policy to Bypass permanently
Write-Host "Setting Execution Policy to Bypass (Permanent - LocalMachine Scope)..."
Set-ExecutionPolicy Bypass -Scope LocalMachine -Force

# Confirm the change
$policy = Get-ExecutionPolicy -Scope LocalMachine
Write-Host "Execution Policy for LocalMachine is now set to: $policy"

if ($policy -eq "Bypass") {
    Write-Host "✅ Permanent Bypass set successfully!"
} else {
    Write-Host "❌ Something went wrong. Check your permissions."
}
