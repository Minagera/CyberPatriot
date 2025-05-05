<#
.SYNOPSIS
    Audits active SMB network shares and their permissions.
.DESCRIPTION
    This script lists all active Server Message Block (SMB) shares on the local machine,
    including administrative shares (like C$, ADMIN$) and user-created shares.
    It attempts to display the permissions associated with each share to help identify
    potentially insecure configurations (e.g., 'Everyone' with Full Control).

    Useful in CyberPatriot for quickly identifying and securing network shares.
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator.
              Requires the SmbShare module (usually available on modern Windows).
              Permission details might be limited without specific ACL cmdlets.
.EXAMPLE
    .\share_audit.ps1
#>

Write-Host "Starting Network Share Audit..." -ForegroundColor Yellow

# Get all SMB shares
try {
    $Shares = Get-SmbShare -ErrorAction Stop
} catch {
    Write-Error "Failed to get SMB shares. Ensure the 'Server' service is running and you have Administrator privileges. Error: $($_.Exception.Message)"
    exit 1
}

if (-not $Shares) {
    Write-Host "No active SMB shares found." -ForegroundColor Green
    exit 0
}

Write-Host "Found $($Shares.Count) active SMB shares."
Write-Host "-------------------------------------"

foreach ($Share in $Shares) {
    Write-Host "Share Name: $($Share.Name)" -ForegroundColor Cyan
    Write-Host "  Path: $($Share.Path)"
    Write-Host "  Description: $($Share.Description)"
    Write-Host "  Scoped: $($Share.Scoped)" # True if not continuously available
    Write-Host "  Scope Name: $($Share.ScopeName)" # Usually '*' for global
    Write-Host "  Encrypt Data: $($Share.EncryptData)" # SMB Encryption status

    # Check for common administrative shares
    if ($Share.Name -match '\$$') { # Ends with $
        Write-Warning "  *** This appears to be an administrative share. ***"
    }

    # Get Share Permissions (Access Control List - ACL)
    Write-Host "  Share Permissions:"
    try {
        $Acl = Get-SmbShareAccess -Name $Share.Name -ErrorAction Stop
        if ($Acl) {
            $Acl | ForEach-Object {
                Write-Host "    Account: $($_.AccountName)"
                Write-Host "      Access: $($_.AccessRight)"
                Write-Host "      Type: $($_.AccessControlType)" # Allow/Deny

                # Check for overly permissive 'Everyone' access
                if ($_.AccountName -eq 'Everyone' -and ($_.AccessRight -eq 'Full' -or $_.AccessRight -eq 'Change')) {
                    Write-Warning "      *** Overly permissive access for 'Everyone' found! ($($_.AccessRight)) ***"
                }
            }
        } else {
            Write-Host "    No specific share permissions found (may use defaults)." -ForegroundColor Gray
        }
    } catch {
        Write-Warning "    Could not retrieve share permissions for '$($Share.Name)'. Error: $($_.Exception.Message)"
    }

    # Note: Getting NTFS permissions for the underlying $Share.Path requires Get-Acl
    # Example:
    # try {
    #     $NtfsAcl = Get-Acl -Path $Share.Path -ErrorAction Stop
    #     Write-Host "  NTFS Permissions (First few):"
    #     $NtfsAcl.Access | Select-Object -First 5 | Format-Table -AutoSize FileSystemRights, AccessControlType, IdentityReference
    # } catch { Write-Warning "    Could not retrieve NTFS permissions for path '$($Share.Path)'."}


    Write-Host "-------------------------------------"
}

Write-Host "Network Share Audit Complete." -ForegroundColor Green
