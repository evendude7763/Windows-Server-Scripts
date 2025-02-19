# Set a blank password for a specific user
$username = "Administrator"
Set-LocalUser -Name $username -Password ([SecureString]::new())