<#
.SYNOPSIS
    Lists running or automatic services and their executable paths.
.DESCRIPTION
    This script retrieves services that are currently running or set to start automatically.
    It displays their name, display name, state, start mode, and the path to the service executable.
    Requires administrative privileges for full path information on some services.
.NOTES
    Run as Administrator for best results.
    Review the 'PathName' carefully for suspicious locations or executables.
    Compare against required services listed in the competition README.
#>
param()

Write-Host "--- Running or Automatic Services ---" -ForegroundColor Yellow

try {
    Get-CimInstance -ClassName Win32_Service | Where-Object {$_.State -eq 'Running' -or $_.StartMode -eq 'Auto'} | Select-Object Name, DisplayName, State, StartMode, PathName | Sort-Object Name | Format-Table -Wrap
} catch {
    Write-Warning "Could not retrieve service information. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
