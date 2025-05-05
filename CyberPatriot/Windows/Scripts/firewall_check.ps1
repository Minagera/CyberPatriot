<#
.SYNOPSIS
    Checks the status of the Windows Defender Firewall for all profiles.
.DESCRIPTION
    This script retrieves and displays the enabled status of the Windows Defender
    Firewall for the Domain, Private, and Public profiles. It helps quickly verify
    if the firewall is active, which is a common requirement in CyberPatriot.
    Optionally, it can list enabled firewall rules (can be very verbose).
.PARAMETER ListEnabledRules
    If specified, the script will also list all currently enabled firewall rules.
    WARNING: This can produce a very large amount of output.
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator.
              Requires the NetSecurity module.
.EXAMPLE
    # Check only the profile status
    .\firewall_check.ps1

.EXAMPLE
    # Check profile status AND list all enabled rules (verbose)
    .\firewall_check.ps1 -ListEnabledRules
#>
param(
    [switch]$ListEnabledRules
)

Write-Host "Checking Windows Defender Firewall Status..." -ForegroundColor Yellow

# Check Firewall Profile Status
try {
    $Profiles = Get-NetFirewallProfile -ErrorAction Stop

    Write-Host "Firewall Profile Status:" -ForegroundColor Cyan
    Write-Host "------------------------"
    foreach ($Profile in $Profiles) {
        Write-Host "Profile: $($Profile.Name)"
        Write-Host "  Enabled: $($Profile.Enabled)" -ForegroundColor ($Profile.Enabled -eq 'True' ? "Green" : "Red")
        Write-Host "  Default Inbound Action: $($Profile.DefaultInboundAction)"
        Write-Host "  Default Outbound Action: $($Profile.DefaultOutboundAction)"
        Write-Host "------------------------"

        if ($Profile.Enabled -ne 'True') {
            Write-Warning "Firewall Profile '$($Profile.Name)' is NOT enabled!"
            # Optionally add code here to attempt enabling it:
            # Set-NetFirewallProfile -Name $Profile.Name -Enabled True
        }
    }
} catch {
    Write-Error "Failed to get Firewall profiles. Is the Firewall service running? Error: $($_.Exception.Message)"
    # Optionally attempt to start the service: Start-Service -Name MpsSvc
    exit 1
}

# List Enabled Rules (Optional)
if ($ListEnabledRules) {
    Write-Host "`nListing Enabled Firewall Rules (This may take a moment)..." -ForegroundColor Yellow
    try {
        $EnabledRules = Get-NetFirewallRule -Enabled True -ErrorAction Stop | Sort-Object -Property DisplayGroup, DisplayName

        if ($EnabledRules) {
            Write-Host "Total Enabled Rules Found: $($EnabledRules.Count)"
            $EnabledRules | Format-Table -AutoSize DisplayName, DisplayGroup, Direction, Action, Profile
            # Use Format-List for more detail:
            # $EnabledRules | Format-List DisplayName, Description, Enabled, Direction, Action, Profile, Program, LocalPort, RemotePort
        } else {
            Write-Host "No enabled firewall rules found."
        }
    } catch {
        Write-Error "Failed to retrieve firewall rules. Error: $($_.Exception.Message)"
    }
}

Write-Host "Firewall Check Complete." -ForegroundColor Green
