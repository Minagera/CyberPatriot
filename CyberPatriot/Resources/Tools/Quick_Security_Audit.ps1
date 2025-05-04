# CyberPatriot Quick Security Audit Script (Windows)

Write-Host "=== Quick Security Audit ==="

Write-Host "Checking local users..."
Get-LocalUser | Format-Table Name, Enabled, LastLogon

Write-Host "Checking Administrators group..."
Get-LocalGroupMember -Group "Administrators" | Format-Table Name, ObjectClass

Write-Host "Checking password policy..."
net accounts

Write-Host "Checking running services..."
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, DisplayName

Write-Host "Checking firewall status..."
Get-NetFirewallProfile | Format-Table Name, Enabled

Write-Host "Checking Defender status..."
Get-MpComputerStatus | Select-Object AMServiceEnabled, RealTimeProtectionEnabled

Write-Host "Checking for pending updates..."
Get-WindowsUpdateLog

Write-Host "Audit complete. Review output for issues."
