<#
.SYNOPSIS
    Sets up a Windows VM with vulnerabilities and forensic artifacts for CyberPatriot training.
.DESCRIPTION
    This script transforms a clean Windows 10/11 installation into a compromised
    workstation scenario for incident response practice. It creates unauthorized users,
    weakens security settings, adds persistence mechanisms, disables security features,
    and creates a scenario README file with forensic questions.

    *** RUN AS ADMINISTRATOR on a clean VM snapshot. ***
    *** This script makes significant security-weakening changes. Use only on dedicated training VMs. ***
.NOTES
    Author: GitHub Copilot (Placeholder - Needs significant expansion)
    Date:   [Current Date]
    Requires: PowerShell 5.1+, Administrator privileges, compatible Windows version (Win 10/11 Pro/Ent recommended).
.EXAMPLE
    # Run from an Administrator PowerShell prompt on the target VM:
    Set-ExecutionPolicy Bypass -Scope Process -Force
    .\enterprise-workstation-setup.ps1
#>

# --- Script Configuration ---
$LogFile = "C:\setup_log_cyberpatriot.txt"
$StartTime = Get-Date

# User Accounts
$AdminUser = "ITAdmin" # Assumes this user exists or creates it
$AdminPass = "Company2023!"
$UnauthorizedUser1 = "jguest"
$UnauthorizedPass1 = "Password123"
$UnauthorizedUser2 = "backupmgr" # Potential hidden admin
$UnauthorizedPass2 = "P@ssw0rd321"
$RequiredUser = "HRUser" # Example required user
$RequiredPass = "HRPass2024$"

# Persistence & Artifacts
$MaliciousTaskName = "AdobeUpdateChecker" # Suspicious task name
$MaliciousTaskAction = "C:\Windows\System32\calc.exe" # Benign placeholder - replace with something more subtle
$RegistryRunKeyName = "SysHelper"
$RegistryRunKeyValue = "C:\Windows\System32\notepad.exe" # Benign placeholder
$ReadmeFileName = "README-Incident.txt"
$FlagFileName = "flag_location.txt"
$FlagContent = "The flag is hidden in C:\ProgramData\SystemData\config.dat" # Example

# --- Logging Function ---
function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO" # INFO, WARN, ERROR
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "[$Timestamp] [$Level] $Message"
    Write-Host $LogEntry
    Add-Content -Path $LogFile -Value $LogEntry
}

# --- Start Setup ---
Clear-Content -Path $LogFile -ErrorAction SilentlyContinue
Write-Log "Starting Enterprise Workstation Compromise Setup Script."
Write-Log "-----------------------------------------------------"

# --- User Account Setup ---
Write-Log "Configuring User Accounts..."

# Ensure primary admin exists and set password (use with caution if user exists)
try {
    $AdminExists = Get-LocalUser -Name $AdminUser -ErrorAction SilentlyContinue
    if (-not $AdminExists) {
        Write-Log "Creating admin user: $AdminUser"
        New-LocalUser -Name $AdminUser -PasswordNeverExpires -Password (ConvertTo-SecureString $AdminPass -AsPlainText -Force) -FullName "IT Administrator" -Description "Primary Admin Account" -ErrorAction Stop
        Add-LocalGroupMember -Group "Administrators" -Member $AdminUser -ErrorAction Stop
    } else {
        Write-Log "Admin user $AdminUser exists. Setting password (ensure this is intended)."
        Get-LocalUser -Name $AdminUser | Set-LocalUser -Password (ConvertTo-SecureString $AdminPass -AsPlainText -Force) -ErrorAction Stop
    }
    Write-Log "Admin user '$AdminUser' configured."
} catch {
    Write-Log "ERROR configuring admin user '$AdminUser': $($_.Exception.Message)" -Level ERROR
}

# Create unauthorized standard user
try {
    Write-Log "Creating unauthorized user: $UnauthorizedUser1"
    New-LocalUser -Name $UnauthorizedUser1 -PasswordNeverExpires:$false -Password (ConvertTo-SecureString $UnauthorizedPass1 -AsPlainText -Force) -FullName "Just Guest" -Description "Unauthorized guest account" -ErrorAction Stop
    Write-Log "Unauthorized user '$UnauthorizedUser1' created."
} catch {
    Write-Log "ERROR creating unauthorized user '$UnauthorizedUser1': $($_.Exception.Message)" -Level ERROR
}

# Create unauthorized user and add to Administrators (hidden admin)
try {
    Write-Log "Creating unauthorized admin user: $UnauthorizedUser2"
    New-LocalUser -Name $UnauthorizedUser2 -PasswordNeverExpires -Password (ConvertTo-SecureString $UnauthorizedPass2 -AsPlainText -Force) -FullName "Backup Manager" -Description "System Backup Service Account" -ErrorAction Stop
    Add-LocalGroupMember -Group "Administrators" -Member $UnauthorizedUser2 -ErrorAction Stop
    Write-Log "Unauthorized admin user '$UnauthorizedUser2' created and added to Administrators."
} catch {
    Write-Log "ERROR creating unauthorized admin user '$UnauthorizedUser2': $($_.Exception.Message)" -Level ERROR
}

# Create required user
try {
    Write-Log "Creating required user: $RequiredUser"
    New-LocalUser -Name $RequiredUser -PasswordNeverExpires:$false -Password (ConvertTo-SecureString $RequiredPass -AsPlainText -Force) -FullName "Human Resources User" -Description "Standard employee account" -ErrorAction Stop
    Write-Log "Required user '$RequiredUser' created."
} catch {
    Write-Log "ERROR creating required user '$RequiredUser': $($_.Exception.Message)" -Level ERROR
}

# Disable Guest Account (if exists)
try {
    $Guest = Get-LocalUser -Name "Guest" -ErrorAction SilentlyContinue
    if ($Guest -and $Guest.Enabled) {
        Write-Log "Disabling Guest account..."
        Disable-LocalUser -Name "Guest" -ErrorAction Stop
    } else {
         Write-Log "Guest account already disabled or does not exist."
    }
} catch {
     Write-Log "ERROR disabling Guest account: $($_.Exception.Message)" -Level ERROR
}


# --- Weaken Security Settings ---
Write-Log "Weakening Security Settings..."

# Example: Weaken Password Policy (using secedit - more complex, consider direct registry edits or skip if too complex for script)
# Write-Log "Setting weak password policy (MinLength=6, Complexity=Disabled)..."
# $SecPolicyFile = Join-Path $env:TEMP "weak_policy.inf"
# @"
# [Unicode]
# Unicode=yes
# [System Access]
# MinimumPasswordLength = 6
# PasswordComplexity = 0
# [Version]
# signature="`$CHICAGO`$"
# Revision=1
# "@ | Set-Content -Path $SecPolicyFile -Encoding Unicode
# secedit.exe /configure /db C:\Windows\security\database\secedit.sdb /cfg $SecPolicyFile /areas SECURITYPOLICY /quiet
# Remove-Item $SecPolicyFile -Force -ErrorAction SilentlyContinue
# Write-Log "Note: Policy changes may require gpupdate /force or reboot to fully apply."

# Example: Disable Firewall Profiles
Write-Log "Disabling Firewall Profiles (Domain, Private, Public)..."
try {
    Set-NetFirewallProfile -Profile Domain, Private, Public -Enabled False -ErrorAction Stop
    Write-Log "Firewall profiles disabled."
} catch {
    Write-Log "ERROR disabling firewall profiles: $($_.Exception.Message)" -Level ERROR
}

# Example: Disable Defender Real-time Monitoring
Write-Log "Disabling Defender Real-time Monitoring..."
try {
    Set-MpPreference -DisableRealtimeMonitoring $true -ErrorAction Stop
    Write-Log "Defender Real-time Monitoring disabled."
} catch {
    Write-Log "ERROR disabling Defender Real-time Monitoring: $($_.Exception.Message)" -Level ERROR
}

# --- Add Persistence Mechanisms ---
Write-Log "Adding Persistence Mechanisms..."

# Malicious Scheduled Task (runs calc.exe as SYSTEM)
Write-Log "Creating malicious scheduled task: $MaliciousTaskName"
try {
    $Action = New-ScheduledTaskAction -Execute $MaliciousTaskAction
    $Trigger = New-ScheduledTaskTrigger -AtLogOn # Example trigger
    $Principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -RunLevel Highest
    Register-ScheduledTask -TaskName $MaliciousTaskName -Action $Action -Trigger $Trigger -Principal $Principal -Description "Checks for important Adobe updates" -Force -ErrorAction Stop
    Write-Log "Scheduled task '$MaliciousTaskName' created."
} catch {
    Write-Log "ERROR creating scheduled task '$MaliciousTaskName': $($_.Exception.Message)" -Level ERROR
}

# Registry Run Key (runs notepad.exe for current user - script needs to run as target user or use HKLM)
# Note: This adds it for the *Administrator* running the script. Modify if needed.
Write-Log "Adding registry Run key: $RegistryRunKeyName"
$RegPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
try {
    if (-not (Test-Path $RegPath)) {
        New-Item -Path $RegPath -Force | Out-Null
    }
    Set-ItemProperty -Path $RegPath -Name $RegistryRunKeyName -Value $RegistryRunKeyValue -ErrorAction Stop
    Write-Log "Registry Run key '$RegistryRunKeyName' added for current user."
} catch {
    Write-Log "ERROR adding registry Run key '$RegistryRunKeyName': $($_.Exception.Message)" -Level ERROR
}

# --- Create Forensic Artifacts ---
Write-Log "Creating Forensic Artifacts..."

# Create README file on Desktop (assuming script runs as Admin, place on default Admin desktop)
$DesktopPath = [System.Environment]::GetFolderPath('Desktop') # Gets desktop of user running script
$ReadmePath = Join-Path $DesktopPath $ReadmeFileName
Write-Log "Creating README file at $ReadmePath"

# Define README Content (Heredoc)
$ReadmeContent = @"
=========================================================
CyberPatriot Incident Response Challenge - README
=========================================================

Scenario:
---------
You are part of the Incident Response team at 'Innovatech Dynamics'. A workstation
belonging to the IT department ($AdminUser) is suspected of being compromised.
Initial reports suggest unauthorized access and potential data exfiltration.
Your team must investigate, contain the threat, remediate vulnerabilities,
and answer the forensic questions below.

Authorized Users:
-----------------
- $AdminUser (IT Administrator)
- $RequiredUser (Human Resources)
- Administrator (Built-in, should be secured)

Required Services/Applications:
-------------------------------
- Standard Windows Services (ensure basic functionality remains)
- Remote Desktop Protocol (RDP) MUST remain accessible for remote admin. (Example Requirement)
- Company HR Application (Simulated - Assume `notepad.exe` represents this)

Prohibited Actions:
-------------------
- Do NOT disable the network connection unless instructed.
- Do NOT delete critical system files.
- Do NOT lock out the $AdminUser account.

Forensic Questions:
-------------------
1.  What is the name of the unauthorized user account added to the Administrators group?
2.  A malicious scheduled task was created to run at logon. What is the name of this task?
3.  What program is configured to run automatically via the HKCU Run key named '$RegistryRunKeyName'?
4.  Find the hidden flag file. What is its full path and filename? (Hint: Look in ProgramData)
5.  Which Windows security feature, responsible for real-time malware protection, was found disabled?

Good luck, analysts! Document all your findings and actions.
"@

try {
    Set-Content -Path $ReadmePath -Value $ReadmeContent -Encoding UTF8 -Force -ErrorAction Stop
    Write-Log "README file created successfully."
} catch {
    Write-Log "ERROR creating README file '$ReadmePath': $($_.Exception.Message)" -Level ERROR
}

# Create hidden flag file
$FlagDirPath = "C:\ProgramData\SystemData" # Example hidden location
$FlagPath = Join-Path $FlagDirPath "config.dat" # Example hidden file
Write-Log "Creating flag file at $FlagPath"
try {
    if (-not (Test-Path $FlagDirPath)) {
        New-Item -Path $FlagDirPath -ItemType Directory -Force | Out-Null
    }
    Set-Content -Path $FlagPath -Value $FlagContent -Force -ErrorAction Stop
    # Optional: Hide the file/directory
    (Get-Item $FlagPath).Attributes += 'Hidden'
    (Get-Item $FlagDirPath).Attributes += 'Hidden'
    Write-Log "Flag file created and hidden."
} catch {
    Write-Log "ERROR creating flag file '$FlagPath': $($_.Exception.Message)" -Level ERROR
}


# --- Final Steps ---
Write-Log "-----------------------------------------------------"
$EndTime = Get-Date
$Duration = New-TimeSpan -Start $StartTime -End $EndTime
Write-Log "Setup script finished at $EndTime"
Write-Log "Total duration: $($Duration.TotalSeconds) seconds"
Write-Host "Setup Complete. Review log file: $LogFile" -ForegroundColor Green
Write-Host "Please take a VM snapshot NOW before distributing to cadets." -ForegroundColor Yellow
