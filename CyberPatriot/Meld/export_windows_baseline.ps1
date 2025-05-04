# CyberPatriot Windows Baselining Script (Unique, original)
# Exports key system state for comparison in CyberPatriot competitions

$baselineDir = "$env:USERPROFILE\Desktop\windows_baseline"
New-Item -ItemType Directory -Path $baselineDir -Force | Out-Null

# Export startup items
reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" "$baselineDir\run.reg" /y

# Export services
reg export "HKLM\SYSTEM\CurrentControlSet\Services" "$baselineDir\services.reg" /y

# Export user accounts
wmic useraccount list full > "$baselineDir\users.txt"

# Export groups and members
net localgroup > "$baselineDir\groups.txt"
foreach ($group in (net localgroup | Select-Object -Skip 6)) {
    $groupName = $group.Trim()
    if ($groupName -and $groupName -ne "The command completed successfully.") {
        net localgroup "$groupName" > "$baselineDir\group_$($groupName).txt"
    }
}

# Export firewall rules
netsh advfirewall export "$baselineDir\firewall.wfw"

# Export scheduled tasks
schtasks /query /fo LIST > "$baselineDir\tasks.txt"

Write-Host "Windows baseline exported to $baselineDir"
