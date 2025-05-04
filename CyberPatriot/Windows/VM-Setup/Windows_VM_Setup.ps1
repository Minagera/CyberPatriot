# CyberPatriot Windows VM Setup Script (Unique Example)
# Run as Administrator

Write-Host "Starting CyberPatriot Windows VM Setup..."

# Create standard user accounts
New-LocalUser -Name "cadet1" -Password (ConvertTo-SecureString "Cadet!2024" -AsPlainText -Force) -FullName "Cadet One" -Description "CyberPatriot Cadet"
Add-LocalGroupMember -Group "Users" -Member "cadet1"

# Remove unauthorized accounts (example)
$unauthorized = @("hacker", "testuser")
foreach ($user in $unauthorized) {
    if (Get-LocalUser -Name $user -ErrorAction SilentlyContinue) {
        Remove-LocalUser -Name $user
    }
}

# Set password policy
secedit /export /cfg C:\Temp\secpol.cfg
(gc C:\Temp\secpol.cfg) -replace 'MinimumPasswordLength = \d+', 'MinimumPasswordLength = 10' | Set-Content C:\Temp\secpol.cfg
secedit /configure /db secedit.sdb /cfg C:\Temp\secpol.cfg

# Enable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $false

# Enable Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

Write-Host "Windows VM setup complete. Please review all settings before competition."
