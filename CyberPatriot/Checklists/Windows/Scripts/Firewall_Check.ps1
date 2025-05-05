<#
.SYNOPSIS
    Checks Windows Firewall profile status and lists enabled inbound allow rules.
.DESCRIPTION
    This script displays the enabled status and default actions for Domain, Private, and Public
    firewall profiles. It also lists all enabled inbound rules with the 'Allow' action,
    excluding the default 'Core Networking' rules for brevity.
    Requires administrative privileges.
.NOTES
    Run as Administrator.
    Verify firewall is enabled for all profiles and default inbound action is 'Block'.
    Review the listed rules against required services/ports in the competition README.
#>
param()

Write-Host "--- Firewall Profile Status ---" -ForegroundColor Yellow
try {
    Get-NetFirewallProfile | Format-Table Name, Enabled, DefaultInboundAction, DefaultOutboundAction
} catch {
    Write-Warning "Could not retrieve firewall profile status. Error: $($_.Exception.Message)"
}

Write-Host "`n--- Enabled Inbound Allow Rules (Excluding Core Networking) ---" -ForegroundColor Yellow
try {
    Get-NetFirewallRule -Direction Inbound -Action Allow -Enabled True | Where-Object {$_.Group -notlike "*Core Networking*"} | Sort-Object DisplayName | Format-Table Name, DisplayName, Group, Profile, Enabled -AutoSize
} catch {
    Write-Warning "Could not retrieve firewall rules. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
