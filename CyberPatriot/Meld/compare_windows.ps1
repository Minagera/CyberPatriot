# CyberPatriot Windows Baseline Comparison Script (unique)

$baseline = "$env:USERPROFILE\baseline"

# Check for Meld installation
$meldPath = (Get-Command meld.exe -ErrorAction SilentlyContinue).Source
if (-not $meldPath) {
    Write-Host "Meld is not installed. Please run install_meld_windows.ps1 first."
    exit 1
}

# Export current configs for comparison
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "$env:TEMP\current_run.reg" /y
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "$env:TEMP\current_services.reg" /y
wmic useraccount list full > "$env:TEMP\current_users.txt"
net localgroup > "$env:TEMP\current_groups.txt"
netsh advfirewall export "$env:TEMP\current_firewall.wfw"
schtasks /query /fo LIST > "$env:TEMP\current_tasks.txt"

# Launch Meld comparisons
Start-Process meld.exe "$baseline\baseline_run.reg" "$env:TEMP\current_run.reg"
Start-Process meld.exe "$baseline\baseline_services.reg" "$env:TEMP\current_services.reg"
Start-Process meld.exe "$baseline\baseline_users.txt" "$env:TEMP\current_users.txt"
Start-Process meld.exe "$baseline\baseline_groups.txt" "$env:TEMP\current_groups.txt"
Start-Process meld.exe "$baseline\baseline_firewall.wfw" "$env:TEMP\current_firewall.wfw"
Start-Process meld.exe "$baseline\baseline_tasks.txt" "$env:TEMP\current_tasks.txt"

Write-Host "Comparison complete. Review Meld windows."
