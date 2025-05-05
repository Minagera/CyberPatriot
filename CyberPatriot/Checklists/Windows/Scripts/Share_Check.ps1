<#
.SYNOPSIS
    Lists network shares and optionally displays their share permissions.
.DESCRIPTION
    This script retrieves all SMB shares configured on the local machine.
    It includes an optional parameter to also display the Access Control List (ACL)
    for each share, showing who has what level of access at the share level.
    Requires administrative privileges.
.PARAMETER ShowPermissions
    If specified, the script will also output the share-level permissions for each share.
.EXAMPLE
    .\Share_Check.ps1
    # Lists only the shares and their paths.

.EXAMPLE
    .\Share_Check.ps1 -ShowPermissions
    # Lists shares, paths, and their share-level permissions.
.NOTES
    Run as Administrator.
    Remember that NTFS permissions on the underlying folder also apply and the most restrictive permission wins.
    Review shares against the competition README and remove unnecessary ones.
    Ensure necessary shares have appropriate, least-privilege permissions. Avoid 'Everyone'.
#>
param(
    [switch]$ShowPermissions
)

Write-Host "--- Network Shares ---" -ForegroundColor Yellow
try {
    $shares = Get-SmbShare | Sort-Object Name
    $shares | Format-Table Name, Path, ScopeName

    if ($ShowPermissions) {
        Write-Host "`n--- Share Permissions ---" -ForegroundColor Yellow
        foreach ($share in $shares) {
            Write-Host "`nShare: $($share.Name) (Path: $($share.Path))" -ForegroundColor Cyan
            try {
                Get-SmbShareAccess -Name $share.Name | Format-Table Name, AccountName, AccessControlType, AccessRight
            } catch {
                Write-Warning "Could not retrieve permissions for share '$($share.Name)'. Error: $($_.Exception.Message)"
            }
        }
    }
} catch {
    Write-Warning "Could not retrieve share information. Error: $($_.Exception.Message)"
}

Write-Host "`nScript finished." -ForegroundColor Green
