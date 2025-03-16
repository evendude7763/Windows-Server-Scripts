# Enable insecure guest authentication
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters" -Name "AllowInsecureGuestAuth" -Value 1

# Restart the Workstation service to apply the change
Restart-Service -Name LanmanWorkstation -Force