<#
.SYNOPSIS
    Audits local user accounts, their status, group memberships, and last logon time.
.DESCRIPTION
    This script retrieves information about local user accounts on a Windows machine.
    It lists each user, whether they are enabled or disabled, their description,
    when they last logged on (if available and auditing is enabled), and which
    local groups they belong to. It specifically highlights members of the
    Administrators group.

    Designed for CyberPatriot training scenarios.
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator for full details.
              LastLogon information might be inaccurate or unavailable depending
              on domain environment and audit settings.
.EXAMPLE
    .\user_audit.ps1
#>

Write-Host "Starting Local User Audit..." -ForegroundColor Yellow

# Get all local users
try {
    $Users = Get-LocalUser -ErrorAction Stop
} catch {
    Write-Error "Failed to get local users. Ensure you are running as Administrator."
    exit 1
}

Write-Host "Total Local Users Found: $($Users.Count)"
Write-Host "-------------------------------------"

foreach ($User in $Users) {
    Write-Host "User: $($User.Name)" -ForegroundColor Cyan
    Write-Host "  Enabled: $($User.Enabled)"
    Write-Host "  Description: $($User.Description)"
    Write-Host "  Last Logon: $($User.LastLogon)" # Note: May not be accurate/available
    Write-Host "  Password Last Set: $($User.PasswordLastSet)"
    Write-Host "  Password Changeable: $($User.PasswordChangeableDate)" # Indicates if user can change pwd
    Write-Host "  Password Required: $($User.PasswordRequired)"
    Write-Host "  Password Never Expires: $($User.PasswordNeverExpires)"

    # Get group memberships
    try {
        $Groups = Get-LocalPrincipalGroupMembership -Principal $User.Name -ErrorAction SilentlyContinue
        if ($Groups) {
            Write-Host "  Member of Groups:"
            $Groups | ForEach-Object { Write-Host "    - $($_.Name)" }
        } else {
            Write-Host "  Member of Groups: None Found"
        }

        # Specifically check for Administrators group membership
        if ($Groups | Where-Object { $_.Name -eq 'Administrators' }) {
            Write-Warning "  *** User '$($User.Name)' is a member of the Administrators group! ***"
        }

    } catch {
        Write-Warning "  Could not retrieve group membership for $($User.Name). Error: $($_.Exception.Message)"
    }
    Write-Host "-------------------------------------"
}

# Specifically list Administrators group members again for summary
Write-Host "Verifying Administrators Group Membership..." -ForegroundColor Yellow
try {
    $Admins = Get-LocalGroupMember -Group "Administrators" -ErrorAction Stop
    Write-Host "Members of 'Administrators' Group:" -ForegroundColor Green
    $Admins | ForEach-Object { Write-Host "  - $($_.Name) ($($_.PrincipalSource))" }
} catch {
    Write-Error "Failed to get members of the Administrators group."
}

Write-Host "User Audit Complete." -ForegroundColor Green
