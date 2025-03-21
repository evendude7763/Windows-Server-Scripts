# Auto-elevate the script to run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Created by: Shawn Brink
# Created on: November 25, 2021
# Tutorial: https://www.elevenforum.com/t/enable-or-disable-location-services-in-windows-11.3003/

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors"

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value to ENABLE location services
Set-ItemProperty -Path $registryPath -Name "DisableLocation" -Value 0

Write-Host "Location services have been enabled." -ForegroundColor Green