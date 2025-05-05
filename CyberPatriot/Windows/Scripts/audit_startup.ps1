<#
.SYNOPSIS
    Audits common Windows startup and persistence locations.
    Designed for CyberPatriot information gathering and baselining.
    Outputs information to the console and optionally to a single file.

.DESCRIPTION
    This script checks the following locations for potential persistence:
    1. Registry Run Keys (HKLM and HKCU).
    2. Registry RunOnce Keys (HKLM and HKCU).
    3. User Startup Folder.
    4. Common Startup Folder.
    5. Scheduled Tasks (basic list).

.PARAMETER OutputFile
    Optional. Specifies the full path to a file where all output will be saved.
    If not specified, output is only sent to the console.

.EXAMPLE
    .\audit_startup.ps1
    # Displays startup/persistence information on the console.

.EXAMPLE
    .\audit_startup.ps1 -OutputFile C:\AuditOutput\StartupAudit.txt
    # Displays info on console and saves all findings to C:\AuditOutput\StartupAudit.txt.

.NOTES
    Author: GitHub Copilot (for Grissom JROTC CyberPatriot)
    Date:   [Current Date]
    Version: 1.0
    Requires: PowerShell 5.0 or later. Run as Administrator for full access (esp. HKLM, Tasks).
    Disclaimer: This script is for educational and CyberPatriot training purposes only.
                Review and test thoroughly before use. No warranty provided.
#>
param(
    [string]$OutputFile
)

# Function to handle output (Console and optional File Append)
function Write-AuditSection {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Header,
        [Parameter(Mandatory=$true)]
        [object]$Data
    )
    $outputString = @"

--------------------------------------------------
$Header
--------------------------------------------------
"@
    # Format data for output - use Format-List for potentially long values
    $outputString += ($Data | Format-List | Out-String).Trim()

    # Console Output
    Write-Host $outputString

    # File Output (Append)
    if ($script:OutputFile) {
        try {
            Add-Content -Path $script:OutputFile -Value $outputString -Encoding UTF8 -ErrorAction Stop
        } catch {
            Write-Error "Failed to append output to file: $($script:OutputFile). $_"
        }
    }
}

# --- Main Script Logic ---

Write-Host "Starting Windows Startup/Persistence Audit..." -ForegroundColor Yellow

# Initialize Output File if specified
if ($OutputFile) {
    if (Test-Path $OutputFile) {
        Write-Host "Output file '$OutputFile' exists, appending timestamp." -ForegroundColor Yellow
        $OutputFile = "$($OutputFile -replace '\.txt$')_$(Get-Date -Format 'yyyyMMddHHmmss').txt"
    }
    try {
        "Windows Startup/Persistence Audit - $(Get-Date)" | Out-File -FilePath $OutputFile -Encoding UTF8 -ErrorAction Stop
        Write-Host "Saving output to: $OutputFile" -ForegroundColor Cyan
    } catch {
         Write-Error "Failed to create output file: $OutputFile. $_"
         $OutputFile = $null # Fallback to console only
    }
}


# 1. Registry Run Keys (HKLM)
try {
    $hklmRunPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'
    if (Test-Path $hklmRunPath) {
        $hklmRunItems = Get-ItemProperty -Path $hklmRunPath | Select-Object * -ExcludeProperty PS* # Exclude PS properties
        Write-AuditSection -Header "Registry Run Keys (HKLM: $hklmRunPath)" -Data $hklmRunItems
    } else { Write-AuditSection -Header "Registry Run Keys (HKLM: $hklmRunPath)" -Data "Path not found."}
} catch { Write-AuditSection -Header "Registry Run Keys (HKLM)" -Data "Error accessing: $_" }

# 2. Registry Run Keys (HKCU) - Needs to run in user context or access HKU hive
try {
    # Attempting for current user - may not be correct if run as different admin
    $hkcuRunPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
     if (Test-Path $hkcuRunPath) {
        $hkcuRunItems = Get-ItemProperty -Path $hkcuRunPath | Select-Object * -ExcludeProperty PS*
        Write-AuditSection -Header "Registry Run Keys (HKCU: $hkcuRunPath - Current User)" -Data $hkcuRunItems
     } else { Write-AuditSection -Header "Registry Run Keys (HKCU: $hkcuRunPath - Current User)" -Data "Path not found."}
     # Note: To check other users, would need to load their NTUSER.DAT hive or use more advanced methods.
} catch { Write-AuditSection -Header "Registry Run Keys (HKCU - Current User)" -Data "Error accessing: $_" }

# 3. Registry RunOnce Keys (HKLM)
try {
    $hklmRunOncePath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce'
     if (Test-Path $hklmRunOncePath) {
        $hklmRunOnceItems = Get-ItemProperty -Path $hklmRunOncePath | Select-Object * -ExcludeProperty PS*
        Write-AuditSection -Header "Registry RunOnce Keys (HKLM: $hklmRunOncePath)" -Data $hklmRunOnceItems
     } else { Write-AuditSection -Header "Registry RunOnce Keys (HKLM: $hklmRunOncePath)" -Data "Path not found."}
} catch { Write-AuditSection -Header "Registry RunOnce Keys (HKLM)" -Data "Error accessing: $_" }

# 4. Registry RunOnce Keys (HKCU)
try {
    $hkcuRunOncePath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'
     if (Test-Path $hkcuRunOncePath) {
        $hkcuRunOnceItems = Get-ItemProperty -Path $hkcuRunOncePath | Select-Object * -ExcludeProperty PS*
        Write-AuditSection -Header "Registry RunOnce Keys (HKCU: $hkcuRunOncePath - Current User)" -Data $hkcuRunOnceItems
     } else { Write-AuditSection -Header "Registry RunOnce Keys (HKCU: $hkcuRunOncePath - Current User)" -Data "Path not found."}
} catch { Write-AuditSection -Header "Registry RunOnce Keys (HKCU - Current User)" -Data "Error accessing: $_" }

# 5. User Startup Folder
try {
    $userStartup = [Environment]::GetFolderPath('Startup')
    if ($userStartup -and (Test-Path $userStartup)) {
        $userStartupItems = Get-ChildItem -Path $userStartup | Select-Object Name, FullName, LastWriteTime
        Write-AuditSection -Header "User Startup Folder ($userStartup)" -Data $userStartupItems
    } else { Write-AuditSection -Header "User Startup Folder" -Data "Path not found or inaccessible."}
} catch { Write-AuditSection -Header "User Startup Folder" -Data "Error accessing: $_" }

# 6. Common Startup Folder
try {
    $commonStartup = [Environment]::GetFolderPath('CommonStartup')
     if ($commonStartup -and (Test-Path $commonStartup)) {
        $commonStartupItems = Get-ChildItem -Path $commonStartup | Select-Object Name, FullName, LastWriteTime
        Write-AuditSection -Header "Common Startup Folder ($commonStartup)" -Data $commonStartupItems
     } else { Write-AuditSection -Header "Common Startup Folder" -Data "Path not found or inaccessible."}
} catch { Write-AuditSection -Header "Common Startup Folder" -Data "Error accessing: $_" }

# 7. Scheduled Tasks (Basic List)
try {
    # Get-ScheduledTask requires Win 8/Server 2012+
    # schtasks /query is more compatible but harder to parse reliably
    $scheduledTasks = Get-ScheduledTask | Where-Object {$_.State -ne 'Disabled'} | Select-Object TaskPath, TaskName, State, Author, @{N='Actions';E={($_.Actions | Select-Object -ExpandProperty Executable -ErrorAction SilentlyContinue) -join '; '}} | Sort-Object TaskPath, TaskName
    Write-AuditSection -Header "Scheduled Tasks (Enabled)" -Data $scheduledTasks
} catch {
    Write-AuditSection -Header "Scheduled Tasks" -Data "Error accessing tasks (requires Admin rights and compatible OS): $_"
    # Fallback using schtasks (less structured output)
    Write-Host "Attempting fallback with schtasks /query..." -ForegroundColor Yellow
    try {
        $schtasksOutput = schtasks /query /fo LIST
        Write-AuditSection -Header "Scheduled Tasks (schtasks /query /fo LIST)" -Data $schtasksOutput
    } catch {
         Write-AuditSection -Header "Scheduled Tasks (schtasks)" -Data "Error running schtasks: $_"
    }
}

# --- Add more checks as needed ---
# e.g., WMI persistence (advanced), Service permissions/recovery options

Write-Host "`nWindows Startup/Persistence Audit Complete." -ForegroundColor Yellow
if ($OutputFile) { Write-Host "Full output saved to: $OutputFile" -ForegroundColor Cyan }
