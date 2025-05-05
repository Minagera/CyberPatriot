<#
.SYNOPSIS
    Creates a baseline snapshot of key Windows system configurations.
    Designed for CyberPatriot baselining. Runs several audit functions and saves
    output to separate files in a specified directory.

.DESCRIPTION
    This script consolidates output from various audit areas into text files
    suitable for comparison using diff tools like Meld. It gathers:
    1. Local Users and Group Memberships (Administrators, RDP Users).
    2. Services (All and Running, with paths).
    3. Common Startup/Persistence Locations (Run Keys, Tasks, Startup Folders).
    4. Basic Network Configuration (IP Config, Firewall Status, Listeners, Hosts file).

.PARAMETER OutputDir
    Mandatory. Specifies the directory path where baseline output files will be saved.
    The directory will be created if it doesn't exist.

.EXAMPLE
    .\baseline_system_snapshot.ps1 -OutputDir C:\Baseline\CleanWin10
    # Runs all audits and saves files like 'AllUsers.txt', 'RunningServices.txt', etc.,
    # into the C:\Baseline\CleanWin10 directory.

.NOTES
    Author: GitHub Copilot (for Grissom JROTC CyberPatriot)
    Date:   [Current Date]
    Version: 1.0
    Requires: PowerShell 5.0 or later. Run as Administrator for full access.
              Relies on the individual audit scripts being present or incorporates their logic.
              This example incorporates logic directly for simplicity.
    Disclaimer: This script is for educational and CyberPatriot training purposes only.
                Review and test thoroughly before use. No warranty provided.
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$OutputDir
)

# --- Helper Functions ---

# Function to safely create output directory
function Ensure-OutputDir {
    param([string]$Path)
    if (-not (Test-Path -Path $Path -PathType Container)) {
        try {
            New-Item -Path $Path -ItemType Directory -Force -ErrorAction Stop | Out-Null
            Write-Host "Created output directory: $Path" -ForegroundColor Green
            return $true
        } catch {
            Write-Error "FATAL: Failed to create output directory: $Path. $_"
            return $false
        }
    }
    return $true
}

# Function to save data to a file within the OutputDir
function Save-AuditData {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Data,
        [Parameter(Mandatory=$true)]
        [string]$FileName,
        [switch]$NoAutoSize,
        [switch]$IsRawString # If $Data is already a string (e.g., from schtasks)
    )
    $filePath = Join-Path -Path $script:OutputDir -ChildPath $FileName
    try {
        if ($IsRawString) {
            $Data | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
        }
        elseif ($NoAutoSize) {
             # Use Wrap for potentially long paths in services/tasks
            $Data | Format-Table -Wrap | Out-String | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
        } else {
            $Data | Format-Table -AutoSize | Out-String | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
        }
        Write-Host " -> Saved $FileName" -ForegroundColor Cyan
    } catch {
        Write-Error "Failed to write output to file: $filePath. $_"
    }
}

# --- Main Script Logic ---

Write-Host "Starting Windows Baseline Snapshot..." -ForegroundColor Yellow

# Validate and Create Output Directory
if (-not (Ensure-OutputDir -Path $OutputDir)) {
    Write-Error "Exiting due to inability to create output directory."
    Exit 1
}

# --- 1. User Audit ---
Write-Host "[+] Auditing Users and Groups..."
try {
    $allUsers = Get-LocalUser | Select-Object Name, Enabled, Description | Sort-Object Name
    Save-AuditData -Data $allUsers -FileName "Baseline_AllUsers.txt"

    $adminMembers = Get-LocalGroupMember -Group "Administrators" | Select-Object Name, PrincipalSource, ObjectClass | Sort-Object Name
    Save-AuditData -Data $adminMembers -FileName "Baseline_AdminGroup.txt"

    $rdpGroup = Get-LocalGroup -Name "Remote Desktop Users" -ErrorAction SilentlyContinue
    if ($rdpGroup) {
        $rdpMembers = Get-LocalGroupMember -Group "Remote Desktop Users" | Select-Object Name, PrincipalSource, ObjectClass | Sort-Object Name
        Save-AuditData -Data $rdpMembers -FileName "Baseline_RDPGroup.txt"
    }
} catch { Write-Error "User Audit Error: $_" }

# --- 2. Service Audit ---
Write-Host "[+] Auditing Services..."
try {
    $allServices = Get-CimInstance -ClassName Win32_Service | Select-Object Name, DisplayName, @{N='Status';E={$_.State}}, @{N='StartType';E={$_.StartMode}}, PathName | Sort-Object Name
    Save-AuditData -Data $allServices -FileName "Baseline_AllServices.txt" -NoAutoSize

    $runningServices = $allServices | Where-Object {$_.Status -eq 'Running'} | Sort-Object Name
    Save-AuditData -Data $runningServices -FileName "Baseline_RunningServices.txt" -NoAutoSize
} catch { Write-Error "Service Audit Error: $_" }

# --- 3. Startup/Persistence Audit ---
Write-Host "[+] Auditing Startup Locations..."
try {
    # HKLM Run
    $hklmRunPath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'
    if(Test-Path $hklmRunPath){ Get-ItemProperty -Path $hklmRunPath | Select-Object * -ExcludeProperty PS* | Format-List | Out-String | Save-AuditData -FileName "Baseline_RegRun_HKLM.txt" -IsRawString }

    # HKCU Run
    $hkcuRunPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'
     if(Test-Path $hkcuRunPath){ Get-ItemProperty -Path $hkcuRunPath | Select-Object * -ExcludeProperty PS* | Format-List | Out-String | Save-AuditData -FileName "Baseline_RegRun_HKCU.txt" -IsRawString }

    # HKLM RunOnce
    $hklmRunOncePath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce'
    if(Test-Path $hklmRunOncePath){ Get-ItemProperty -Path $hklmRunOncePath | Select-Object * -ExcludeProperty PS* | Format-List | Out-String | Save-AuditData -FileName "Baseline_RegRunOnce_HKLM.txt" -IsRawString }

    # HKCU RunOnce
    $hkcuRunOncePath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce'
    if(Test-Path $hkcuRunOncePath){ Get-ItemProperty -Path $hkcuRunOncePath | Select-Object * -ExcludeProperty PS* | Format-List | Out-String | Save-AuditData -FileName "Baseline_RegRunOnce_HKCU.txt" -IsRawString }

    # User Startup Folder
    $userStartup = [Environment]::GetFolderPath('Startup')
    if ($userStartup -and (Test-Path $userStartup)) { Get-ChildItem -Path $userStartup | Select-Object Name, FullName, LastWriteTime | Save-AuditData -FileName "Baseline_UserStartupFolder.txt" }

    # Common Startup Folder
    $commonStartup = [Environment]::GetFolderPath('CommonStartup')
    if ($commonStartup -and (Test-Path $commonStartup)) { Get-ChildItem -Path $commonStartup | Select-Object Name, FullName, LastWriteTime | Save-AuditData -FileName "Baseline_CommonStartupFolder.txt" }

    # Scheduled Tasks (Enabled)
    $scheduledTasks = Get-ScheduledTask | Where-Object {$_.State -ne 'Disabled'} | Select-Object TaskPath, TaskName, State, Author, @{N='Actions';E={($_.Actions | Select-Object -ExpandProperty Executable -ErrorAction SilentlyContinue) -join '; '}} | Sort-Object TaskPath, TaskName
    Save-AuditData -Data $scheduledTasks -FileName "Baseline_ScheduledTasks_Enabled.txt" -NoAutoSize

} catch { Write-Error "Startup Audit Error: $_" }


# --- 4. Network Audit ---
Write-Host "[+] Auditing Network Configuration..."
try {
    # IP Config
    $ipConfig = Get-NetIPConfiguration | Where-Object {$_.InterfaceOperationalStatus -eq 'Up'}
    $ipConfig | Format-List | Out-String | Save-AuditData -FileName "Baseline_IPConfig.txt" -IsRawString

    # Firewall Profiles
    $fwProfiles = Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
    Save-AuditData -Data $fwProfiles -FileName "Baseline_FirewallProfiles.txt"

    # TCP Listeners
    $tcpListeners = Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort, OwningProcess | Sort-Object LocalPort
    Save-AuditData -Data $tcpListeners -FileName "Baseline_TCPListeners.txt"

     # UDP Listeners
    $udpListeners = Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort | Sort-Object LocalPort
    Save-AuditData -Data $udpListeners -FileName "Baseline_UDPListeners.txt"

    # Hosts File
    $hostsPath = Join-Path -Path $env:SystemRoot -ChildPath "System32\drivers\etc\hosts"
    if (Test-Path $hostsPath) { Get-Content -Path $hostsPath | Save-AuditData -FileName "Baseline_HostsFile.txt" -IsRawString }

} catch { Write-Error "Network Audit Error: $_" }


# --- Add more baseline areas as needed ---
# e.g., Installed Software (Get-Package), Specific Policy Settings, File Permissions (more complex)

Write-Host "`nWindows Baseline Snapshot Complete. Files saved in: $OutputDir" -ForegroundColor Yellow
