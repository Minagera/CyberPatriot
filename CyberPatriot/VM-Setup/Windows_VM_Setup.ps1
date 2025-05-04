# CyberPatriot Windows VM Setup Script (Unique for Training)

# 1. Create a new local user for practice
New-LocalUser -Name "cybercadet" -Password (ConvertTo-SecureString "P@ssw0rd123" -AsPlainText -Force) -FullName "CyberPatriot Cadet" -Description "Practice user for CyberPatriot"

# 2. Add user to Administrators group
Add-LocalGroupMember -Group "Administrators" -Member "cybercadet"

# 3. Disable Guest account
Disable-LocalUser -Name "Guest"

# 4. Enable Windows Defender real-time protection
Set-MpPreference -DisableRealtimeMonitoring $false

# 5. Enable Windows Firewall for all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True

# 6. Create a vulnerable service for practice (for exercise)
New-Service -Name "VulnService" -BinaryPathName "C:\Windows\System32\notepad.exe" -DisplayName "Vulnerable Service" -StartupType Manual

# 7. Output setup completion
Write-Host "Windows VM setup for CyberPatriot training complete."
