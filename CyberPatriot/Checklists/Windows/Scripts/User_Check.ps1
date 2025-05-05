<#
.SYNOPSIS
    Lists enabled local users and members of critical local groups.
.DESCRIPTION
    This script retrieves a list of all enabled local user accounts and displays
    the members of the local Administrators and Remote Desktop Users groups.
    Requires administrative privileges to run correctly.
.NOTES
    Run as Administrator.
    Verify output against the competition README for authorized users/groups.
#>
param()

Write-Host "--- Enabled Local Users ---" -ForegroundColor Yellow
try {
    Get-LocalUser | Where-Object {$_.Enabled -eq $true} | Format-Table Name, Description, Enabled, LastLogon
} catch {
    Write-Warning "Could not retrieve local users. Error: $($_.Exception.Message)"
}

Write-Host "`n--- Administrators Group Members ---" -ForegroundColor Yellow
try {
    Get-LocalGroupMember -Group "Administrators" | Format-Table Name, PrincipalSource
} catch {
    Write-Warning "Could not retrieve Administrators group members. Error: $($_.Exception.Message)"
}

Write-Host "`n--- Remote Desktop Users Group Members ---" -ForegroundColor Yellow
try {
    Get-LocalGroupMember -Group "Remote Desktop Users" | Format-Table Name, PrincipalSource
} catch {
    Write-Warning "Could not retrieve Remote Desktop Users group members. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
