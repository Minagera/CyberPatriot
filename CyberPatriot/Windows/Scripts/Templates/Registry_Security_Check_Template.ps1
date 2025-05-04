# Registry Security Check Template for CyberPatriot

Write-Host "=== Registry Security Check ==="

# Check for AutoAdminLogon
$winlogon = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Write-Host "AutoAdminLogon: $($winlogon.AutoAdminLogon)"
if ($winlogon.DefaultPassword) {
    Write-Host "DefaultPassword is set! This is a security risk." -ForegroundColor Red
}

# Check LSA security settings
$lsa = Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
Write-Host "LmCompatibilityLevel: $($lsa.LmCompatibilityLevel)"
Write-Host "NoLMHash: $($lsa.NoLMHash)"
Write-Host "RestrictAnonymous: $($lsa.RestrictAnonymous)"

# Check Run keys for suspicious startup items
$runKeys = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
    "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
)
foreach ($key in $runKeys) {
    if (Test-Path $key) {
        Write-Host "Startup items in $key:"
        Get-ItemProperty -Path $key | Format-Table
    }
}

Write-Host "=== End of Registry Security Check ==="
