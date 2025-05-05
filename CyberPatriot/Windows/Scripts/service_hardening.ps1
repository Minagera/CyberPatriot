<#
.SYNOPSIS
    Identifies potentially unnecessary/risky Windows services and offers to disable them.
.DESCRIPTION
    This script checks the status of commonly disabled services in CyberPatriot scenarios
    (e.g., Remote Registry, Telnet, SNMP). It reports their current status (Running/Stopped)
    and Startup Type. It can optionally prompt the user to disable these services.

    *** WARNING: Disabling services can break system functionality. ***
    *** Always verify if a service is required by the competition README or for essential system operation. ***
    *** Use with extreme caution. Designed for CyberPatriot training scenarios. ***
.PARAMETER AutoDisable
    If specified, the script will attempt to disable the targeted services without prompting.
    *** USE THIS PARAMETER WITH EXTREME CAUTION! ***
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator.
.EXAMPLE
    # Run in interactive mode (prompts before disabling)
    .\service_hardening.ps1

.EXAMPLE
    # Run in automatic mode (attempts to disable without prompting - DANGEROUS)
    .\service_hardening.ps1 -AutoDisable
#>
param(
    [switch]$AutoDisable
)

Write-Host "Starting Service Hardening Check..." -ForegroundColor Yellow
Write-Warning "This script identifies potentially unnecessary services."
Write-Warning "Disabling services can impact system functionality. Verify requirements before proceeding."
Write-Warning "Always check the competition README file first!"

# List of services commonly checked/disabled in CyberPatriot
# Add or remove services based on common scenarios and README files
$TargetServices = @(
    "RemoteRegistry",   # Allows remote registry modification
    "TlntSvr",          # Telnet Server (Highly insecure)
    "SNMP",             # SNMP Service (Can leak info if misconfigured)
    "RemoteAccess",     # Routing and Remote Access (Often disabled unless needed)
    "Fax"               # Fax service (Usually unnecessary)
    # "Spooler"         # Print Spooler (Sometimes disabled if no printing needed, but can break things)
    # "TermService"     # Remote Desktop Services (Disable only if RDP is explicitly forbidden/not needed)
)

Write-Host "Checking status of target services:" -ForegroundColor Cyan
Write-Host "----------------------------------"

foreach ($ServiceName in $TargetServices) {
    try {
        $Service = Get-Service -Name $ServiceName -ErrorAction Stop

        Write-Host "Service: $($Service.DisplayName) ($($Service.Name))"
        Write-Host "  Status: $($Service.Status)"
        Write-Host "  Startup Type: $($Service.StartType)"

        if ($Service.StartType -ne [System.ServiceProcess.ServiceStartMode]::Disabled) {
            Write-Warning "  Service '$($Service.Name)' is not Disabled."

            if ($AutoDisable) {
                $Confirm = $true
            } else {
                $Response = Read-Host "Do you want to attempt to disable '$($Service.Name)'? (y/n)"
                if ($Response -eq 'y') {
                    $Confirm = $true
                } else {
                    $Confirm = $false
                    Write-Host "  Skipping disable action for $($Service.Name)."
                }
            }

            if ($Confirm) {
                Write-Host "  Attempting to disable '$($Service.Name)'..." -ForegroundColor Yellow
                try {
                    # Stop the service first (if running)
                    if ($Service.Status -eq 'Running') {
                        Write-Host "    Stopping service..."
                        Stop-Service -Name $ServiceName -Force -ErrorAction Stop
                        Write-Host "    Service stopped." -ForegroundColor Green
                    }

                    # Set startup type to Disabled
                    Write-Host "    Setting startup type to Disabled..."
                    Set-Service -Name $ServiceName -StartupType Disabled -ErrorAction Stop
                    Write-Host "    Startup type set to Disabled." -ForegroundColor Green
                } catch {
                    Write-Error "    Failed to disable service '$($ServiceName)'. Error: $($_.Exception.Message)"
                }
            }
        } else {
            Write-Host "  Service '$($Service.Name)' is already Disabled." -ForegroundColor Green
        }

    } catch [Microsoft.PowerShell.Commands.ServiceCommandException] {
        Write-Host "Service: $ServiceName"
        Write-Host "  Status: Not Found/Installed" -ForegroundColor Gray
    } catch {
        Write-Error "An error occurred checking service '$ServiceName': $($_.Exception.Message)"
    }
    Write-Host "----------------------------------"
}

Write-Host "Service Hardening Check Complete." -ForegroundColor Green
