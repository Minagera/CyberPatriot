# Enable-WindowsDefender.ps1
# Ensures Windows Defender is enabled and up to date

Set-MpPreference -DisableRealtimeMonitoring $false
Start-MpScan -ScanType QuickScan
Update-MpSignature

Write-Host "Windows Defender enabled and updated."
