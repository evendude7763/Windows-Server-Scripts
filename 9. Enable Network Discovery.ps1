# Enable Network Discovery for all network profiles (Domain, Private, Public)
Set-NetFirewallRule -DisplayGroup "Network Discovery" -Enabled True -Profile Domain,Private,Public

# Verify the status of Network Discovery rules
Get-NetFirewallRule -DisplayGroup "Network Discovery" | Select-Object Name, DisplayName, Enabled