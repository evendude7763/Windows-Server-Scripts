# Auto-elevate the script to run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Set the time zone to "Central Standard Time" (Chicago)
Set-TimeZone -Id "Central Standard Time"

# Confirm the change
$currentTimeZone = Get-TimeZone
Write-Host "The time zone has been set to: $($currentTimeZone.Id)" -ForegroundColor Green