<#
.SYNOPSIS
    Audits Windows services, focusing on running status, startup type, and executable path.
    Designed for CyberPatriot information gathering and baselining.
    Outputs information to the console and optionally to files.

.DESCRIPTION
    This script performs the following actions:
    1. Lists all services with their Name, DisplayName, Status, StartType, and PathName.
    2. Highlights services that are currently running.
    3. (Optional) Outputs the full list and running list to separate text files.

.PARAMETER OutputDir
    Optional. Specifies the directory path where output files will be saved.
    If not specified, output is only sent to the console.

.EXAMPLE
    .\audit_services.ps1
    # Displays service information on the console.

.EXAMPLE
    .\audit_services.ps1 -OutputDir C:\AuditOutput
    # Displays info on console and saves 'AllServices.txt' and 'RunningServices.txt' to C:\AuditOutput.

.NOTES
    Author: GitHub Copilot (for Grissom JROTC CyberPatriot)
    Date:   [Current Date]
    Version: 1.0
    Requires: PowerShell 5.0 or later. Run as Administrator (to get PathName reliably).
    Disclaimer: This script is for educational and CyberPatriot training purposes only.
                Review and test thoroughly before use. No warranty provided.
#>
param(
    [string]$OutputDir
)

# Function to safely create output directory if specified
function Ensure-OutputDir {
    if ($OutputDir) {
        if (-not (Test-Path -Path $OutputDir -PathType Container)) {
            try {
                New-Item -Path $OutputDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
                Write-Host "Created output directory: $OutputDir" -ForegroundColor Green
            } catch {
                Write-Error "Failed to create output directory: $OutputDir. $_"
                # Fallback to console output only
                $script:OutputDir = $null
            }
        }
    }
}

# Function to handle output (Console and optional File)
function Write-AuditOutput {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Data,
        [string]$FileName,
        [switch]$NoAutoSize # Use if Format-Table -AutoSize might truncate PathName
    )
    # Console Output
    if ($NoAutoSize) {
         # Adjust width as needed, or use Format-List for long paths
        $Data | Format-Table -Property Name, DisplayName, Status, StartType, PathName -Wrap | Out-String | Write-Host
    } else {
        $Data | Format-Table -AutoSize | Out-String | Write-Host
    }


    # File Output (if OutputDir is set)
    if ($script:OutputDir -and $FileName) {
        $filePath = Join-Path -Path $script:OutputDir -ChildPath $FileName
        try {
            # Use Out-String to preserve Format-Table layout in file
            if ($NoAutoSize) {
                $Data | Format-Table -Property Name, DisplayName, Status, StartType, PathName -Wrap | Out-String | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
            } else {
                 $Data | Format-Table -AutoSize | Out-String | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
            }
            Write-Host "Output saved to: $filePath" -ForegroundColor Cyan
        } catch {
            Write-Error "Failed to write output to file: $filePath. $_"
        }
    }
}

# --- Main Script Logic ---

Write-Host "Starting Windows Service Audit..." -ForegroundColor Yellow
Ensure-OutputDir

# 1. Get All Services with Path Information
Write-Host "`n[+] All Services:" -ForegroundColor Green
try {
    # Using Get-CimInstance is generally preferred for richer info like PathName
    $allServices = Get-CimInstance -ClassName Win32_Service | Select-Object Name, DisplayName, State, StartMode, PathName | Sort-Object Name
    # Remap State/StartMode for clarity if desired (e.g., State -> Status, StartMode -> StartType)
    $allServicesFormatted = $allServices | Select-Object Name, DisplayName, @{N='Status';E={$_.State}}, @{N='StartType';E={$_.StartMode}}, PathName
    # Use NoAutoSize because PathName can be very long
    Write-AuditOutput -Data $allServicesFormatted -FileName "AllServices.txt" -NoAutoSize
} catch {
    Write-Error "Failed to get service information using CIM. $_"
    # Fallback to Get-Service (may lack PathName without admin rights)
    try {
         Write-Host "Falling back to Get-Service (PathName might be missing)..." -ForegroundColor Yellow
         $allServicesFallback = Get-Service | Select-Object Name, DisplayName, Status, StartType | Sort-Object Name
         Write-AuditOutput -Data $allServicesFallback -FileName "AllServices_Basic.txt"
    } catch {
        Write-Error "Failed to get service information using Get-Service. $_"
    }
}

# 2. Filter for Running Services
Write-Host "`n[+] Running Services:" -ForegroundColor Green
if ($allServicesFormatted) {
    $runningServices = $allServicesFormatted | Where-Object {$_.Status -eq 'Running'} | Sort-Object Name
    if ($runningServices) {
        Write-AuditOutput -Data $runningServices -FileName "RunningServices.txt" -NoAutoSize
    } else {
        Write-Host "No services reported as running."
    }
} elseif ($allServicesFallback) {
     $runningServicesFallback = $allServicesFallback | Where-Object {$_.Status -eq 'Running'} | Sort-Object Name
     if ($runningServicesFallback) {
        Write-AuditOutput -Data $runningServicesFallback -FileName "RunningServices_Basic.txt"
     } else {
         Write-Host "No services reported as running."
     }
} else {
    Write-Host "Could not retrieve service list to filter running services." -ForegroundColor Yellow
}


# --- Add more checks as needed ---
# e.g., Filter for services running as LocalSystem, check service permissions (more advanced)

Write-Host "`nWindows Service Audit Complete." -ForegroundColor Yellow
