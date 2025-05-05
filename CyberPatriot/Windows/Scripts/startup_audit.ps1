<#
.SYNOPSIS
    Audits common Windows startup locations and scheduled tasks for review.
.DESCRIPTION
    This script checks common locations where programs are configured to run at
    startup (Registry Run keys, Startup folders) and lists active scheduled tasks.
    This helps identify potentially unauthorized or malicious persistence mechanisms
    in CyberPatriot scenarios.
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator for full details.
.EXAMPLE
    .\startup_audit.ps1
#>

Write-Host "Starting Startup and Scheduled Task Audit..." -ForegroundColor Yellow

# --- Registry Run Keys ---
Write-Host "`nChecking Registry Run Keys..." -ForegroundColor Cyan
$RunKeys = @(
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Run", # 32-bit on 64-bit OS
    "HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\RunOnce",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce"
)

foreach ($keyPath in $RunKeys) {
    Write-Host "Checking Key: $keyPath"
    try {
        if (Test-Path $keyPath) {
            $items = Get-ItemProperty -Path $keyPath -ErrorAction Stop
            # Exclude the default property
            $valueNames = $items.PSObject.Properties.Name | Where-Object { $_ -ne 'PSPath' -and $_ -ne 'PSParentPath' -and $_ -ne 'PSChildName' -and $_ -ne 'PSDrive' -and $_ -ne 'PSProvider' -and $_ -ne '(default)' }

            if ($valueNames) {
                foreach ($valueName in $valueNames) {
                    Write-Host "  Name: $valueName"
                    Write-Host "    Command: $($items.$valueName)" -ForegroundColor White
                }
            } else {
                Write-Host "  No startup items found in this key." -ForegroundColor Gray
            }
        } else {
            Write-Host "  Key not found." -ForegroundColor Gray
        }
    } catch {
        Write-Warning "  Could not access key '$keyPath'. Error: $($_.Exception.Message)"
    }
}

# --- Startup Folders ---
Write-Host "`nChecking Startup Folders..." -ForegroundColor Cyan
$StartupFolders = @(
    "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup", # Current User
    "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"  # All Users
)

foreach ($folderPath in $StartupFolders) {
    Write-Host "Checking Folder: $folderPath"
    try {
        if (Test-Path $folderPath) {
            $items = Get-ChildItem -Path $folderPath -ErrorAction Stop
            if ($items) {
                $items | ForEach-Object {
                    Write-Host "  Item: $($_.Name)"
                    if ($_.Extension -eq '.lnk') {
                        # Attempt to resolve shortcut target
                        try {
                            $shell = New-Object -ComObject WScript.Shell
                            $shortcut = $shell.CreateShortcut($_.FullName)
                            Write-Host "    Target: $($shortcut.TargetPath)" -ForegroundColor White
                            Write-Host "    Arguments: $($shortcut.Arguments)" -ForegroundColor White
                        } catch {
                            Write-Warning "    Could not resolve shortcut target for $($_.Name)."
                        }
                    } else {
                         Write-Host "    Type: $($_.GetType().Name)" -ForegroundColor White
                    }
                }
            } else {
                Write-Host "  No startup items found in this folder." -ForegroundColor Gray
            }
        } else {
            Write-Host "  Folder not found." -ForegroundColor Gray
        }
    } catch {
        Write-Warning "  Could not access folder '$folderPath'. Error: $($_.Exception.Message)"
    }
}


# --- Scheduled Tasks ---
Write-Host "`nChecking Scheduled Tasks (excluding Microsoft tasks)..." -ForegroundColor Cyan
try {
    # Get tasks, excluding common Microsoft paths to reduce noise. Add more paths if needed.
    $Tasks = Get-ScheduledTask | Where-Object { $_.TaskPath -notlike '\Microsoft\*' -and $_.State -ne 'Disabled' } | Sort-Object TaskPath, TaskName

    if ($Tasks) {
        Write-Host "Found $($Tasks.Count) non-Microsoft, enabled scheduled tasks."
        $Tasks | ForEach-Object {
            Write-Host "Task: $($_.TaskPath)$($_.TaskName)"
            Write-Host "  State: $($_.State)"
            Write-Host "  Author: $($_.Author)"
            Write-Host "  Principal: $($_.Principal.UserID) ($($_.Principal.RunLevel))"
            Write-Host "  Triggers:"
            $_.Triggers | ForEach-Object { Write-Host "    - $($_.GetType().Name)" } # Basic trigger type
            Write-Host "  Actions:"
            $_.Actions | ForEach-Object { Write-Host "    - $($_.GetType().Name): $($_.Execute) $($_.Arguments)" }
            Write-Host "----------------------------------"
        }
    } else {
        Write-Host "No non-Microsoft, enabled scheduled tasks found." -ForegroundColor Green
    }
} catch {
    Write-Error "Failed to retrieve scheduled tasks. Error: $($_.Exception.Message)"
}

Write-Host "`nStartup and Scheduled Task Audit Complete." -ForegroundColor Green
