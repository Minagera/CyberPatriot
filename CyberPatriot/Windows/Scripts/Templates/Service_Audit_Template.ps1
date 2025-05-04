# Service Audit Template for CyberPatriot

Write-Host "=== Service Audit ==="

# List all running services
Get-Service | Where-Object {$_.Status -eq "Running"} | Format-Table Name, DisplayName

# List services set to start automatically
Get-Service | Where-Object {$_.StartType -eq "Automatic"} | Format-Table Name, Status

# Find insecure services (Telnet, Remote Registry, FTP, SNMP, Print Spooler)
Write-Host "Check for insecure services:"
Get-Service | Where-Object { $_.Name -match "telnet|RemoteRegistry|ftpsvc|SNMP|Spooler" }

Write-Host "=== End of Service Audit ==="
