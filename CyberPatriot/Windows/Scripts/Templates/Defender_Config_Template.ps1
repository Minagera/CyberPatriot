# Windows Defender Configuration Template for CyberPatriot

Write-Host "=== Windows Defender Configuration ==="

# Enable Defender
Set-MpPreference -DisableRealtimeMonitoring $false

# Run a full scan
Start-MpScan -ScanType FullScan

# Update virus definitions
Update-MpSignature

# Enable controlled folder access (optional, Windows 10/11)
# Set-MpPreference -EnableControlledFolderAccess Enabled

# Add exclusion example (if needed)
# Add-MpPreference -ExclusionPath "C:\ExamplePath"

Write-Host "=== End of Defender Configuration ==="
