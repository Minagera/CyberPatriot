<#
.SYNOPSIS
    Checks the status of Windows Defender Antivirus and attempts to update signatures.
.DESCRIPTION
    This script retrieves the status of Windows Defender Antivirus, including whether
    real-time protection is enabled and the current signature version/age. It then
    attempts to initiate a signature update using the Update-MpSignature cmdlet.

    Useful in CyberPatriot for ensuring basic AV protection is active and up-to-date
    (if internet access is available and allowed).
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator.
              Requires the Defender module. Internet access needed for updates.
.EXAMPLE
    .\defender_update.ps1
#>

Write-Host "Checking Windows Defender Antivirus Status..." -ForegroundColor Yellow

# Check Defender Status
try {
    $DefenderStatus = Get-MpComputerStatus -ErrorAction Stop

    Write-Host "Windows Defender Status:" -ForegroundColor Cyan
    Write-Host "  Antispyware Enabled: $($DefenderStatus.AntispywareEnabled)"
    Write-Host "  Antivirus Enabled: $($DefenderStatus.AntivirusEnabled)"
    Write-Host "  Behavior Monitor Enabled: $($DefenderStatus.BehaviorMonitorEnabled)"
    Write-Host "  IOAV Protection Enabled: $($DefenderStatus.IoavProtectionEnabled)"
    Write-Host "  NIAS Enabled (Network Inspection): $($DefenderStatus.NisEnabled)"
    Write-Host "  On-Access Protection Enabled: $($DefenderStatus.OnAccessProtectionEnabled)"
    Write-Host "  Real-time Protection Enabled: $($DefenderStatus.RealTimeProtectionEnabled)" -ForegroundColor ($DefenderStatus.RealTimeProtectionEnabled ? "Green" : "Red")

    Write-Host "  Antivirus Signature Version: $($DefenderStatus.AntivirusSignatureVersion)"
    Write-Host "  Antispyware Signature Version: $($DefenderStatus.AntispywareSignatureVersion)"
    Write-Host "  NIAS Signature Version: $($DefenderStatus.NisSignatureVersion)"
    Write-Host "  Signature Last Updated: $($DefenderStatus.AntivirusSignatureLastUpdated)"
    Write-Host "  Signatures Age (Days): $($DefenderStatus.AntivirusSignatureAge)"

    if (-not $DefenderStatus.AntivirusEnabled -or -not $DefenderStatus.RealTimeProtectionEnabled) {
        Write-Warning "Defender Antivirus or Real-time Protection is NOT enabled!"
        # Optionally add code here to attempt enabling it, e.g., Set-MpPreference -DisableRealtimeMonitoring $false
    }

} catch {
    Write-Error "Failed to get Windows Defender status. Is the Defender service running? Error: $($_.Exception.Message)"
    # Optionally attempt to start the service: Start-Service -Name WinDefend
    # Exit if status cannot be determined, as update attempt might fail
    exit 1
}

# Attempt Signature Update
Write-Host "`nAttempting to Update Defender Signatures..." -ForegroundColor Yellow
Write-Host "(This requires internet access and may take a moment)"
try {
    Update-MpSignature -ErrorAction Stop
    Write-Host "Defender Signature Update command executed successfully." -ForegroundColor Green
    Write-Host "Run this script again after a few minutes to check the updated signature version/age."
} catch {
    Write-Error "Failed to update Defender signatures. Check internet connectivity and Defender service status. Error: $($_.Exception.Message)"
}

Write-Host "Defender Check and Update Attempt Complete." -ForegroundColor Green
