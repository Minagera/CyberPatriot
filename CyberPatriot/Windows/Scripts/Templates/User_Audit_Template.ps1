#==============================================================================
# User Account Audit Template for CyberPatriot
# Purpose: Audit user accounts and security settings on a Windows system
# Usage: Run as Administrator in PowerShell
#==============================================================================

# Script Configuration
$ReportFile = "C:\Temp\UserAudit_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
$ExportCSV = "C:\Temp\UserAccounts_$(Get-Date -Format 'yyyyMMdd_HHmmss').csv"
$LogFile = "C:\Temp\UserAudit_Log_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"

# Create Output Directory
if (-not (Test-Path "C:\Temp")) {
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

#==============================================================================
# Function Definitions
#==============================================================================

function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [string]$Message,
        [ValidateSet("INFO", "WARNING", "ERROR")]
        [string]$Level = "INFO"
    )
    
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $LogEntry = "$Timestamp [$Level] $Message"
    
    # Output to console with color
    switch ($Level) {
        "INFO"    { Write-Host $LogEntry -ForegroundColor Green }
        "WARNING" { Write-Host $LogEntry -ForegroundColor Yellow }
        "ERROR"   { Write-Host $LogEntry -ForegroundColor Red }
    }
    
    # Output to log file
    $LogEntry | Out-File -FilePath $LogFile -Append
}

function Get-SecurityStatus {
    Write-Log "Starting User Account Security Audit"
    
    # Add report header
    "===========================================================================" | Out-File -FilePath $ReportFile
    "                        USER ACCOUNT SECURITY AUDIT                         " | Out-File -FilePath $ReportFile -Append
    "===========================================================================" | Out-File -FilePath $ReportFile -Append
    "Computer: $env:COMPUTERNAME" | Out-File -FilePath $ReportFile -Append
    "Date: $(Get-Date)" | Out-File -FilePath $ReportFile -Append
    "===========================================================================" | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    # Get local users and export to CSV
    Get-LocalUser | Select-Object Name, Enabled, PasswordRequired, PasswordExpires, LastLogon, Description, SID | 
        Export-Csv -Path $ExportCSV -NoTypeInformation
    Write-Log "Exported user details to CSV: $ExportCSV"
    
    # Get account count
    $Users = Get-LocalUser
    $EnabledUsers = $Users | Where-Object { $_.Enabled -eq $true }
    $DisabledUsers = $Users | Where-Object { $_.Enabled -eq $false }
    
    # Write user summary to report
    "USER ACCOUNT SUMMARY:" | Out-File -FilePath $ReportFile -Append
    "Total User Accounts: $($Users.Count)" | Out-File -FilePath $ReportFile -Append
    "Enabled Accounts: $($EnabledUsers.Count)" | Out-File -FilePath $ReportFile -Append
    "Disabled Accounts: $($DisabledUsers.Count)" | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    # Check for potentially concerning accounts
    $AdminSIDPattern = "*-500"
    $GuestSIDPattern = "*-501"
    $BuiltInAdmin = $Users | Where-Object { $_.SID -like $AdminSIDPattern }
    $GuestAccount = $Users | Where-Object { $_.SID -like $GuestSIDPattern }
    
    "BUILT-IN ACCOUNT STATUS:" | Out-File -FilePath $ReportFile -Append
    "Administrator Account (Original Name): $($BuiltInAdmin.Name)" | Out-File -FilePath $ReportFile -Append
    "Administrator Account Status: $(if ($BuiltInAdmin.Enabled) { 'ENABLED (SECURITY CONCERN)' } else { 'Disabled (Good)' })" | Out-File -FilePath $ReportFile -Append
    "Guest Account Status: $(if ($GuestAccount.Enabled) { 'ENABLED (SECURITY CONCERN)' } else { 'Disabled (Good)' })" | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    # Check password policy
    "PASSWORD POLICY:" | Out-File -FilePath $ReportFile -Append
    $NetAccounts = net accounts
    $NetAccounts | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    # Get accounts with no password
    $NoPasswordAccounts = $Users | Where-Object { -not $_.PasswordRequired -and $_.Enabled }
    if ($NoPasswordAccounts) {
        "ACCOUNTS WITH NO PASSWORD REQUIRED (SECURITY CONCERN):" | Out-File -FilePath $ReportFile -Append
        $NoPasswordAccounts | ForEach-Object {
            "- $($_.Name)" | Out-File -FilePath $ReportFile -Append
        }
        "" | Out-File -FilePath $ReportFile -Append
        
        Write-Log "Found $($NoPasswordAccounts.Count) accounts with no password required" -Level WARNING
    }
    
    # Get accounts with passwords that never expire
    $NeverExpiresAccounts = $Users | Where-Object { $_.PasswordExpires -eq $null -and $_.Enabled }
    if ($NeverExpiresAccounts) {
        "ACCOUNTS WITH PASSWORDS THAT NEVER EXPIRE:" | Out-File -FilePath $ReportFile -Append
        $NeverExpiresAccounts | ForEach-Object {
            "- $($_.Name)" | Out-File -FilePath $ReportFile -Append
        }
        "" | Out-File -FilePath $ReportFile -Append
        
        Write-Log "Found $($NeverExpiresAccounts.Count) accounts with passwords that never expire" -Level WARNING
    }
    
    # Check administrators group
    "ADMINISTRATORS GROUP MEMBERS:" | Out-File -FilePath $ReportFile -Append
    try {
        $AdminMembers = Get-LocalGroupMember -Group "Administrators" -ErrorAction Stop
        $AdminMembers | ForEach-Object {
            "- $($_.Name)" | Out-File -FilePath $ReportFile -Append
        }
        
        Write-Log "Found $($AdminMembers.Count) members in the Administrators group"
    }
    catch {
        "Error retrieving Administrators group members: $_" | Out-File -FilePath $ReportFile -Append
        Write-Log "Error retrieving Administrators group members: $_" -Level ERROR
    }
    "" | Out-File -FilePath $ReportFile -Append
    
    # Get suspicious accounts (unusual names or descriptions)
    # NOTE: Customize this section based on your environment
    "ACCOUNTS WITH POTENTIAL SUSPICIOUS NAMES OR DESCRIPTIONS:" | Out-File -FilePath $ReportFile -Append
    $SuspiciousTerms = @("temp", "test", "hack", "admin", "root", "backup", "bin", "anonymous")
    $SuspiciousAccounts = $Users | Where-Object {
        $suspicious = $false
        foreach ($term in $SuspiciousTerms) {
            if ($_.Name -like "*$term*" -or $_.Description -like "*$term*") {
                $suspicious = $true
                break
            }
        }
        $suspicious
    }
    
    if ($SuspiciousAccounts) {
        $SuspiciousAccounts | ForEach-Object {
            "- $($_.Name) (Description: $($_.Description))" | Out-File -FilePath $ReportFile -Append
        }
        
        Write-Log "Found $($SuspiciousAccounts.Count) potentially suspicious accounts" -Level WARNING
    }
    else {
        "None found." | Out-File -FilePath $ReportFile -Append
    }
    "" | Out-File -FilePath $ReportFile -Append
    
    # Check for recently created accounts
    "RECENTLY CREATED ACCOUNTS (LAST 30 DAYS):" | Out-File -FilePath $ReportFile -Append
    $RecentAccounts = $Users | Where-Object {
        $_ | Get-Member -Name "CreateDate" -ErrorAction SilentlyContinue
    } | Where-Object {
        $_.CreateDate -gt (Get-Date).AddDays(-30)
    }
    
    if ($RecentAccounts) {
        $RecentAccounts | ForEach-Object {
            "- $($_.Name) (Created: $($_.CreateDate))" | Out-File -FilePath $ReportFile -Append
        }
        
        Write-Log "Found $($RecentAccounts.Count) accounts created in the last 30 days"
    }
    else {
        "None found." | Out-File -FilePath $ReportFile -Append
    }
    "" | Out-File -FilePath $ReportFile -Append
    
    # Get account lockout policy
    "ACCOUNT LOCKOUT POLICY:" | Out-File -FilePath $ReportFile -Append
    $LockoutPolicy = net accounts | Select-String -Pattern "Lockout"
    $LockoutPolicy | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    # Check for locked accounts
    "LOCKED ACCOUNTS:" | Out-File -FilePath $ReportFile -Append
    $LockedAccounts = Get-WmiObject Win32_UserAccount -Filter "Lockout=True AND LocalAccount=True"
    if ($LockedAccounts) {
        $LockedAccounts | ForEach-Object {
            "- $($_.Name)" | Out-File -FilePath $ReportFile -Append
        }
        
        Write-Log "Found $($LockedAccounts.Count) locked accounts"
    }
    else {
        "None found." | Out-File -FilePath $ReportFile -Append
    }
    "" | Out-File -FilePath $ReportFile -Append
    
    # Check User Account Control settings
    "USER ACCOUNT CONTROL (UAC) SETTINGS:" | Out-File -FilePath $ReportFile -Append
    $UACSettings = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA", "ConsentPromptBehaviorAdmin", "ConsentPromptBehaviorUser", "FilterAdministratorToken" -ErrorAction SilentlyContinue
    
    if ($UACSettings) {
        "UAC Enabled: $($UACSettings.EnableLUA -eq 1)" | Out-File -FilePath $ReportFile -Append
        "Admin Consent Prompt Behavior: $($UACSettings.ConsentPromptBehaviorAdmin)" | Out-File -FilePath $ReportFile -Append
        "User Consent Prompt Behavior: $($UACSettings.ConsentPromptBehaviorUser)" | Out-File -FilePath $ReportFile -Append
        "Filter Administrator Token: $($UACSettings.FilterAdministratorToken -eq 1)" | Out-File -FilePath $ReportFile -Append
        
        # Check if UAC is disabled
        if ($UACSettings.EnableLUA -ne 1) {
            Write-Log "WARNING: UAC is disabled" -Level WARNING
        }
    }
    else {
        "Error retrieving UAC settings." | Out-File -FilePath $ReportFile -Append
        Write-Log "Error retrieving UAC settings" -Level ERROR
    }
    "" | Out-File -FilePath $ReportFile -Append
    
    # Add security recommendations to report
    "SECURITY RECOMMENDATIONS:" | Out-File -FilePath $ReportFile -Append
    "1. Ensure the built-in Administrator account is renamed and disabled when not in use" | Out-File -FilePath $ReportFile -Append
    "2. Ensure the Guest account is disabled" | Out-File -FilePath $ReportFile -Append
    "3. Remove or disable any unauthorized or unnecessary user accounts" | Out-File -FilePath $ReportFile -Append
    "4. Ensure all accounts have strong password requirements" | Out-File -FilePath $ReportFile -Append
    "5. Limit membership in the Administrators group to only necessary accounts" | Out-File -FilePath $ReportFile -Append
    "6. Enable account lockout policies to prevent brute force attacks" | Out-File -FilePath $ReportFile -Append
    "7. Ensure User Account Control (UAC) is enabled" | Out-File -FilePath $ReportFile -Append
    "" | Out-File -FilePath $ReportFile -Append
    
    Write-Log "User Account Security Audit completed. Report saved to: $ReportFile"
}

#==============================================================================
# Main Script Execution
#==============================================================================

# Start the audit
try {
    # Check if running with administrator privileges
    $CurrentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object Security.Principal.WindowsPrincipal($CurrentUser)
    $AdminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
    
    if (-not $Principal.IsInRole($AdminRole)) {
        Write-Log "This script must be run as Administrator. Please restart with elevated privileges." -Level ERROR
        exit 1
    }
    
    # Run the security audit
    Get-SecurityStatus
    
    # Open the report file
    Write-Log "Opening report file..."
    Invoke-Item $ReportFile
    
    Write-Log "Script execution completed successfully"
}
catch {
    Write-Log "An error occurred during script execution: $_" -Level ERROR
}

# End of script

# User Audit Template for CyberPatriot

Write-Host "=== User Audit Report ==="

# List all local users
Get-LocalUser | Format-Table Name, Enabled, LastLogon

# List members of Administrators group
Write-Host "Administrators group members:"
Get-LocalGroupMember -Group "Administrators" | Format-Table Name, ObjectClass

# Find disabled accounts
Write-Host "Disabled accounts:"
Get-LocalUser | Where-Object { $_.Enabled -eq $false } | Format-Table Name

# Find accounts with passwords that never expire
Write-Host "Accounts with non-expiring passwords:"
Get-LocalUser | Where-Object { $_.PasswordNeverExpires } | Format-Table Name

# Find hidden admin accounts (SID ending in 500)
Write-Host "Hidden admin accounts (SID ending in 500):"
Get-LocalUser | Where-Object { $_.SID -like "*-500" } | Format-Table Name, SID

Write-Host "=== End of Audit ==="
