# Check if the script is running with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Relaunch the script with elevated privileges
    Start-Process powershell "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Prompt the user for the new computer name
$newComputerName = Read-Host "Enter the new name for the server"

# Validate the new computer name
if ([string]::IsNullOrWhiteSpace($newComputerName)) {
    Write-Host "The computer name cannot be empty. Please try again." -ForegroundColor Red
    exit 1
}

# Rename the computer
try {
    Rename-Computer -ComputerName $env:COMPUTERNAME -NewName $newComputerName -Force -PassThru -ErrorAction Stop
    Write-Host "Computer name will be changed to '$newComputerName' after restart." -ForegroundColor Green
} catch {
    Write-Host "Failed to rename the computer: $_" -ForegroundColor Red
    exit 1
}

# Prompt the user to restart the computer
$restart = Read-Host "Do you want to restart the computer now to apply the changes? (Y/N)"
if ($restart -eq 'Y' -or $restart -eq 'y') {
    Restart-Computer -Force
} else {
    Write-Host "Please restart the computer manually to apply the changes." -ForegroundColor Yellow
}