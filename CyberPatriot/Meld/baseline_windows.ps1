# CyberPatriot Windows Baseline Creation Script (unique for CyberPatriot)

$baseline = "$env:USERPROFILE\baseline"
New-Item -ItemType Directory -Force -Path $baseline | Out-Null

# Export registry keys
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "$baseline\baseline_run.reg" /y
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "$baseline\baseline_services.reg" /y

# Export user and group info
wmic useraccount list full > "$baseline\baseline_users.txt"
net localgroup > "$baseline\baseline_groups.txt"

# Export firewall and scheduled tasks
netsh advfirewall export "$baseline\baseline_firewall.wfw"
schtasks /query /fo LIST > "$baseline\baseline_tasks.txt"

Write-Host "Windows baseline created at $baseline"
