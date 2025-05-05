<#
.SYNOPSIS
    Audits basic Windows network configuration and status.
    Designed for CyberPatriot information gathering and baselining.
    Outputs information to the console and optionally to a single file.

.DESCRIPTION
    This script checks the following network aspects:
    1. IP Configuration (using Get-NetIPConfiguration).
    2. Firewall Profiles Status (using Get-NetFirewallProfile).
    3. Active TCP/UDP Listeners (using Get-NetTCPConnection).
    4. Contents of the Hosts file.

.PARAMETER OutputFile
    Optional. Specifies the full path to a file where all output will be saved.
    If not specified, output is only sent to the console.

.EXAMPLE
    .\audit_network.ps1
    # Displays network information on the console.

.EXAMPLE
    .\audit_network.ps1 -OutputFile C:\AuditOutput\NetworkAudit.txt
    # Displays info on console and saves all findings to C:\AuditOutput\NetworkAudit.txt.

.NOTES
    Author: GitHub Copilot (for Grissom JROTC CyberPatriot)
    Date:   [Current Date]
    Version: 1.0
    Requires: PowerShell 4.0 or later (for Get-Net* cmdlets). Run as Administrator for best results.
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
    # Format data for output - use Format-List for potentially complex objects
    if ($Data -is [string] -or $Data -is [array]) {
         $outputString += ($Data | Out-String).Trim()
    } else {
         $outputString += ($Data | Format-List | Out-String).Trim()
    }


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

Write-Host "Starting Windows Network Audit..." -ForegroundColor Yellow

# Initialize Output File if specified
if ($OutputFile) {
     if (Test-Path $OutputFile) {
        Write-Host "Output file '$OutputFile' exists, appending timestamp." -ForegroundColor Yellow
        $OutputFile = "$($OutputFile -replace '\.txt$')_$(Get-Date -Format 'yyyyMMddHHmmss').txt"
    }
    try {
        "Windows Network Audit - $(Get-Date)" | Out-File -FilePath $OutputFile -Encoding UTF8 -ErrorAction Stop
        Write-Host "Saving output to: $OutputFile" -ForegroundColor Cyan
    } catch {
         Write-Error "Failed to create output file: $OutputFile. $_"
         $OutputFile = $null # Fallback to console only
    }
}

# 1. IP Configuration
try {
    # Get detailed IP config for interfaces that are Up
    $ipConfig = Get-NetIPConfiguration | Where-Object {$_.InterfaceOperationalStatus -eq 'Up'}
    Write-AuditSection -Header "IP Configuration (Interfaces Status=Up)" -Data $ipConfig
} catch {
    Write-AuditSection -Header "IP Configuration" -Data "Error getting IP config (requires PSv4+): $_"
    # Fallback to ipconfig /all (less structured)
     Write-Host "Attempting fallback with ipconfig /all..." -ForegroundColor Yellow
    try {
        $ipconfigOutput = ipconfig /all
        Write-AuditSection -Header "IP Configuration (ipconfig /all)" -Data $ipconfigOutput
    } catch {
         Write-AuditSection -Header "IP Configuration (ipconfig)" -Data "Error running ipconfig: $_"
    }
}

# 2. Firewall Profiles Status
try {
    $fwProfiles = Get-NetFirewallProfile | Select-Object Name, Enabled, DefaultInboundAction, DefaultOutboundAction
    Write-AuditSection -Header "Firewall Profiles Status" -Data $fwProfiles
} catch { Write-AuditSection -Header "Firewall Profiles Status" -Data "Error getting firewall profiles (requires PSv4+): $_" }

# 3. Active TCP/UDP Listeners
try {
    # Get TCP connections in Listen state
    $tcpListeners = Get-NetTCPConnection -State Listen | Select-Object LocalAddress, LocalPort, OwningProcess | Sort-Object LocalPort
    Write-AuditSection -Header "Active TCP Listeners" -Data $tcpListeners

    # Get UDP listeners (State is not applicable, just get endpoints)
    # Note: Getting OwningProcess for UDP listeners requires more work (e.g., correlating with Get-Process)
    # Keeping it simple for basic audit
    $udpListeners = Get-NetUDPEndpoint | Select-Object LocalAddress, LocalPort | Sort-Object LocalPort
    Write-AuditSection -Header "Active UDP Listeners" -Data $udpListeners

} catch {
    Write-AuditSection -Header "Active Listeners" -Data "Error getting network connections (requires PSv4+): $_"
     # Fallback to netstat -ano (less structured)
     Write-Host "Attempting fallback with netstat -ano..." -ForegroundColor Yellow
    try {
        $netstatOutput = netstat -ano
        Write-AuditSection -Header "Network Connections (netstat -ano)" -Data $netstatOutput
    } catch {
         Write-AuditSection -Header "Network Connections (netstat)" -Data "Error running netstat: $_"
    }
}

# 4. Hosts File Content
try {
    $hostsPath = Join-Path -Path $env:SystemRoot -ChildPath "System32\drivers\etc\hosts"
    if (Test-Path $hostsPath) {
        $hostsContent = Get-Content -Path $hostsPath
        # Filter out comments and blank lines for cleaner view
        $activeHostsEntries = $hostsContent | Where-Object {$_ -notmatch '^\s*#' -and $_ -match '\S'}
        Write-AuditSection -Header "Hosts File Content ($hostsPath) - Active Entries" -Data $activeHostsEntries
    } else {
        Write-AuditSection -Header "Hosts File Content ($hostsPath)" -Data "Hosts file not found."
    }
} catch { Write-AuditSection -Header "Hosts File Content ($hostsPath)" -Data "Error accessing hosts file: $_" }


# --- Add more checks as needed ---
# e.g., Specific firewall rules, network shares (Get-SmbShare)

Write-Host "`nWindows Network Audit Complete." -ForegroundColor Yellow
if ($OutputFile) { Write-Host "Full output saved to: $OutputFile" -ForegroundColor Cyan }
