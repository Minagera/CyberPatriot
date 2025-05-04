# CyberPatriot Windows Incident Response Scenario Setup Script
# Unique for Grissom JROTC CyberPatriot Training

# Exit on error
$ErrorActionPreference = "Stop"

# --- Customizable Variables ---
$PrimaryUser = "ITAdmin"
$PrimaryPass = "Company2023!"
$BackdoorUser = "svc_monitor"
$BackdoorPass = "SvcMonitor!2024"
$LogFile = "C:\setup_log_cyberpatriot.txt"
$ReadmePath = "$env:PUBLIC\Desktop\README.txt"

# Logging function
function Log-Step($msg) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp $msg" | Out-File -FilePath $LogFile -Append
}

# 1. Create Backdoor User
Log-Step "Creating backdoor user..."
net user $BackdoorUser $BackdoorPass /add
net localgroup Administrators $BackdoorUser /add

# 2. Disable Security Features
Log-Step "Disabling Defender and Firewall..."
Set-MpPreference -DisableRealtimeMonitoring $true
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# 3. Add Malicious Scheduled Task
Log-Step "Adding malicious scheduled task..."
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `"Start-Sleep 60; Add-Content C:\temp\persistence.txt 'Persistence Active'`""
$Trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "SystemMonitorUpdate" -Action $Action -Trigger $Trigger -User "SYSTEM" -RunLevel Highest -Force

# 4. Registry Autorun
Log-Step "Adding registry autorun..."
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "Updater" -Value "powershell.exe -NoProfile -WindowStyle Hidden -Command `"Start-Sleep 30; Add-Content C:\temp\autorun.txt 'Autorun Active'`""

# 5. Create Competition README
Log-Step "Creating README.txt on desktop..."
@"
====================================================
Enterprise Workstation Compromise - Incident Response Scenario

You are the security analyst for a small business. The workstation has been compromised. Your tasks:
- Remove all unauthorized users and persistence mechanisms
- Re-enable security features (Defender, Firewall)
- Harden system settings per company policy
- Answer forensic questions in this README

AUTHORIZED USERS:
- $PrimaryUser (IT Admin)

FORENSIC QUESTIONS:
1. What persistence mechanisms did the attacker use?
2. Which registry keys were modified for persistence?
3. What evidence of lateral movement exists in the logs?
4. What password policy is currently enforced?

Good luck!
====================================================
"@ | Out-File -FilePath $ReadmePath -Encoding UTF8

# 6. Set Primary User Password
Log-Step "Setting primary user password..."
net user $PrimaryUser $PrimaryPass

# 7. Log completion
Log-Step "Setup complete. VM is ready for CyberPatriot training."
Write-Host "Setup complete. Review $ReadmePath for scenario details."
