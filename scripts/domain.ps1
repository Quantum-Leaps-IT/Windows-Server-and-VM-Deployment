# Define parameters
$DomainName = "yourdomain.local"        # Replace with your desired domain name
$SafeModeAdministratorPassword = "YourSecurePassword"  # Replace with a strong password
$ForestMode = "7"       # Specify the forest mode value for Windows Server 2016 (See Note below)

# Install AD DS if not already installed
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promote the server to a domain controller
Install-ADDSForest `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -DomainMode $ForestMode `
    -DomainName $DomainName `
    -ForestMode $ForestMode `
    -InstallDns:$true `
    -LogPath "C:\Windows\NTDS" `
    -NoRebootOnCompletion:$false `
    -SysvolPath "C:\Windows\SYSVOL" `
    -Force:$true

# Set the SafeModeAdministratorPassword
$SafeModeAdministratorCred = (New-Object System.Management.Automation.PSCredential ("$DomainName\Administrator", (ConvertTo-SecureString -AsPlainText $SafeModeAdministratorPassword -Force)))

# Sleep for a short time to allow AD DS to complete installation before setting the password
Start-Sleep -Seconds 10

Set-ADAccountPassword -Identity Administrator -NewPassword $SafeModeAdministratorPassword -Credential $SafeModeAdministratorCred

# Force a reboot to complete the promotion
Restart-Computer -Force
