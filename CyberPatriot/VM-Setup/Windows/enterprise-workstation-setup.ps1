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

<#
.SYNOPSIS
Configures a clean Windows VM into a compromised state for CyberPatriot training.
Scenario: "Enterprise Workstation Compromise" - Simulates an HR workstation breach.

.DESCRIPTION
This script introduces vulnerabilities and persistence mechanisms typical in CyberPatriot:
- Creates unauthorized user accounts (standard and admin).
- Weakens password policies.
- Disables or misconfigures Windows Defender Firewall/Antivirus.
- Adds malicious scheduled tasks.
- Adds malicious registry run key entries.
- (Optional) Installs an insecure application or service.
- Creates a competition-style README file with scenario and forensic questions.

.NOTES
Version: 1.0
Author: GitHub Copilot (Conceptual Example)
Requires: Run as Administrator on Windows 10/11 Pro/Enterprise.
Disclaimer: FOR EDUCATIONAL/TRAINING PURPOSES ONLY. Run only on isolated VMs.
#>

# --- Configuration ---
$logFile = "C:\setup_log_cyberpatriot.txt"
$unauthStandardUser = "TempUser123"
$unauthStandardPass = "Password123" # Weak password
$unauthAdminUser = "SysAdminBackup"
$unauthAdminPass = "P@sswOrd321!" # Slightly better, but discoverable
$readmePath = "C:\Users\Public\Desktop\README-Incident.txt"

# --- Functions ---
Function Write-Log {
    Param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] $Message"
    Write-Host $logEntry
    Add-Content -Path $logFile -Value $logEntry
}

# --- Main Script ---
Clear-Content -Path $logFile -ErrorAction SilentlyContinue
Write-Log "Starting CyberPatriot Windows VM Setup: Enterprise Workstation Compromise"

# 1. Create Unauthorized Users
Write-Log "Creating unauthorized users..."
try {
    New-LocalUser -Name $unauthStandardUser -Password (ConvertTo-SecureString $unauthStandardPass -AsPlainText -Force) -FullName "Temporary Account" -Description "Unauthorized standard user" -PasswordNeverExpires:$false -UserMayNotChangePassword:$false -ErrorAction Stop
    New-LocalUser -Name $unauthAdminUser -Password (ConvertTo-SecureString $unauthAdminPass -AsPlainText -Force) -FullName "Backup System Admin" -Description "Unauthorized admin account" -PasswordNeverExpires:$false -UserMayNotChangePassword:$false -ErrorAction Stop
    Add-LocalGroupMember -Group "Administrators" -Member $unauthAdminUser -ErrorAction Stop
    Write-Log "Successfully created users: $unauthStandardUser, $unauthAdminUser (Admin)"
} catch {
    Write-Log "Error creating users: $($_.Exception.Message)"
}

# 2. Weaken Security Policies (Example: Minimum Password Length)
Write-Log "Weakening minimum password length policy..."
# Using secedit to export, modify, and import policy - more robust than direct registry edits
# This is complex, providing a conceptual placeholder. A real script would use:
# secedit /export /cfg C:\secpol.cfg
# (Modify C:\secpol.cfg - e.g., MinimumPasswordLength = 4)
# secedit /configure /db C:\windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
# For simplicity here, we just log the intent.
Write-Log "(Placeholder) Intended to set MinimumPasswordLength to 4 via Local Security Policy."
# Alternative (less reliable): Set-ItemProperty -Path "Registry::HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "MinimumPasswordLength" -Value 4

# 3. Misconfigure Firewall (Example: Allow RDP Inbound)
Write-Log "Misconfiguring Windows Firewall (Allowing RDP)..."
try {
    # Ensure RDP is enabled first (often disabled by default on client OS)
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0 -ErrorAction Stop
    # Enable the firewall rule
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop" -ErrorAction Stop
    Write-Log "Enabled Remote Desktop firewall rules."
} catch {
    Write-Log "Error configuring firewall for RDP: $($_.Exception.Message)"
}

# 4. Add Persistence - Scheduled Task (Example: Runs notepad periodically)
Write-Log "Adding persistence via Scheduled Task..."
try {
    $taskName = "SystemUpdateCheck" # Deceptive name
    $taskCommand = "C:\Windows\System32\notepad.exe"
    $taskTrigger = New-ScheduledTaskTrigger -AtLogon # Runs when any user logs on
    $taskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest # Runs as SYSTEM
    $taskAction = New-ScheduledTaskAction -Execute $taskCommand
    Register-ScheduledTask -TaskName $taskName -Trigger $taskTrigger -Principal $taskPrincipal -Action $taskAction -Description "Checks for system updates (Not really)" -Force -ErrorAction Stop
    Write-Log "Created scheduled task: $taskName"
} catch {
    Write-Log "Error creating scheduled task: $($_.Exception.Message)"
}

# 5. Add Persistence - Registry Run Key (Example: Opens calc on logon)
Write-Log "Adding persistence via Registry Run Key..."
try {
    $regPath = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"
    $regName = "CalcStart"
    $regValue = "C:\Windows\System32\calc.exe"
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -ErrorAction Stop
    Write-Log "Added registry run key: $regName"
} catch {
    Write-Log "Error adding registry run key: $($_.Exception.Message)"
}

# 6. Create Competition README File
Write-Log "Creating competition README file at $readmePath..."
$readmeContent = @"
===========================================================
CyberPatriot Training Scenario: Enterprise Workstation Compromise
===========================================================

Scenario Date: $(Get-Date -Format "yyyy-MM-dd")
System Role: Human Resources Workstation (WIN-HRDEPT01)

Situation:
----------
This workstation, belonging to the HR department, has been exhibiting unusual behavior, including unexpected pop-ups and slow performance. There are concerns about unauthorized access and potential data exfiltration. You are the incident response team tasked with investigating, cleaning, and securing this machine.

Authorized Users:
-----------------
- HRUser01 (Standard User)
- ITAdmin (Administrator - For your use)

Required Services/Applications:
-------------------------------
- Standard Windows Services (Ensure core functionality remains)
- Remote Desktop Protocol (RDP) must remain accessible for ITAdmin ONLY.
- Microsoft Edge Browser
- Calculator (calc.exe) - *Note: Its startup behavior might be suspicious.*

Prohibited Actions:
-------------------
- Do NOT disable core networking services required for scoring.
- Do NOT change the IP address configuration.
- Do NOT remove the ITAdmin account.

Forensic Questions:
-------------------
1. Identify the username of one unauthorized standard user account found on the system.
2. Identify the username of one unauthorized administrator account found on the system.
3. What is the name of the scheduled task configured to run notepad.exe at logon?
4. What registry run key was added to automatically start calc.exe?
5. Besides the authorized users, which specific user account(s) were added? (List all)

Your Tasks:
-----------
1. Identify and remove all unauthorized user accounts.
2. Identify and remove all persistence mechanisms (scheduled tasks, registry keys, etc.).
3. Correct any weakened security policies (e.g., password length).
4. Ensure Windows Defender Antivirus is enabled and updated.
5. Configure the Windows Defender Firewall to allow ONLY necessary traffic (including RDP for ITAdmin) and block everything else inbound.
6. Secure all remaining authorized accounts with strong passwords.
7. Answer the forensic questions in a text file named 'answers.txt' on the Desktop.

Good luck, team! Secure the system!
===========================================================
"@
try {
    Set-Content -Path $readmePath -Value $readmeContent -Encoding UTF8 -Force -ErrorAction Stop
    Write-Log "Successfully created README file."
} catch {
    Write-Log "Error creating README file: $($_.Exception.Message)"
}

Write-Log "CyberPatriot Windows VM Setup Script finished."
Write-Log "Review the log file: $logFile"
Write-Log "Please SHUT DOWN the VM now and take a snapshot."

# End of Script
