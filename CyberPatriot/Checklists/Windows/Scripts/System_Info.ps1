<#
.SYNOPSIS
    Gathers basic OS information, Windows Defender status, and UAC status.
.DESCRIPTION
    This script provides a quick overview of the operating system version, hostname,
    current user, the real-time protection status of Windows Defender, and whether
    User Account Control (UAC) is enabled via the registry setting.
    Requires administrative privileges for UAC check.
.NOTES
    Run as Administrator.
    Useful for initial reconnaissance and verification.
#>
param()

Write-Host "--- System Information ---" -ForegroundColor Yellow
try {
    Get-ComputerInfo | Select-Object OsName, OsVersion, CsName, CsUserName
} catch {
    Write-Warning "Could not retrieve basic system info. Error: $($_.Exception.Message)"
}

Write-Host "`n--- Windows Defender Status ---" -ForegroundColor Yellow
try {
    $defenderStatus = Get-MpComputerStatus
    Write-Host "Real-Time Protection Enabled: $($defenderStatus.RealTimeProtectionEnabled)"
    Write-Host "Antispyware Signature Version: $($defenderStatus.AntispywareSignatureVersion)"
    Write-Host "Antivirus Signature Version: $($defenderStatus.AntivirusSignatureVersion)"
    Write-Host "Last Quick Scan: $($defenderStatus.QuickScanEndTime)"
    Write-Host "Last Full Scan: $($defenderStatus.FullScanEndTime)"
} catch {
    Write-Warning "Could not retrieve Windows Defender status (is the service running?). Error: $($_.Exception.Message)"
}

Write-Host "`n--- UAC Status (EnableLUA) ---" -ForegroundColor Yellow
try {
    $uacValue = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System').EnableLUA
    if ($uacValue -eq 1) {
        Write-Host "UAC (EnableLUA) is Enabled (Value: $uacValue)"
    } else {
        Write-Host "UAC (EnableLUA) is Disabled (Value: $uacValue)" -ForegroundColor Red
    }
} catch {
    Write-Warning "Could not retrieve UAC status from registry. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
