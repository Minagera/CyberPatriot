<#
.SYNOPSIS
    Checks common persistence locations like Run keys, Scheduled Tasks, and Startup folders.
.DESCRIPTION
    This script queries HKLM and HKCU Run/RunOnce keys, lists enabled scheduled tasks,
    and checks the contents of the user and common startup folders.
    Requires administrative privileges to query HKLM keys and all scheduled tasks.
.NOTES
    Run as Administrator.
    Review the output for any unauthorized or suspicious entries.
    Investigate unfamiliar programs, scripts, or task actions.
#>
param()

Write-Host "--- HKLM Run Keys ---" -ForegroundColor Yellow
try {
    Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' | Out-String
    Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce' | Out-String
    # Check Wow6432Node for 32-bit apps on 64-bit systems
    if ((Get-WmiObject Win32_OperatingSystem).OSArchitecture -eq '64-bit') {
        Get-ItemProperty 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run' | Out-String
        Get-ItemProperty 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce' | Out-String
    }
} catch {
    Write-Warning "Could not retrieve HKLM Run keys. Error: $($_.Exception.Message)"
}

Write-Host "`n--- HKCU Run Keys (Current User) ---" -ForegroundColor Yellow
# Note: This runs in the context of the user running the script (likely Administrator)
# To check other users, you might need to load their registry hive (advanced).
try {
    Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' | Out-String
    Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce' | Out-String
} catch {
    Write-Warning "Could not retrieve HKCU Run keys. Error: $($_.Exception.Message)"
}


Write-Host "`n--- Enabled Scheduled Tasks ---" -ForegroundColor Yellow
try {
    Get-ScheduledTask | Where-Object {$_.State -ne 'Disabled'} | Format-Table TaskPath, TaskName, State, Author -AutoSize
} catch {
    Write-Warning "Could not retrieve scheduled tasks. Error: $($_.Exception.Message)"
}

Write-Host "`n--- User Startup Folder Contents ---" -ForegroundColor Yellow
$userStartup = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Host "Checking: $userStartup"
try {
    Get-ChildItem -Path $userStartup | Format-Table Name, Length, LastWriteTime
} catch {
    Write-Warning "Could not access user startup folder. Error: $($_.Exception.Message)"
}

Write-Host "`n--- All Users Startup Folder Contents ---" -ForegroundColor Yellow
$commonStartup = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\Startup"
Write-Host "Checking: $commonStartup"
try {
    Get-ChildItem -Path $commonStartup | Format-Table Name, Length, LastWriteTime
} catch {
    Write-Warning "Could not access common startup folder. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
