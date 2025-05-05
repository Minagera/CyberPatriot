<#
.SYNOPSIS
    Configures recommended advanced audit policy settings using auditpol.exe.
.DESCRIPTION
    This script uses auditpol.exe to enable Success and Failure auditing for key security
    event categories recommended in the checklist, such as Account Logon, Account Management,
    Logon/Logoff, Policy Change, and System events. It also enables Failure auditing for
    Privilege Use and Object Access.
    WARNING: This script makes changes to the system's audit policy.
.NOTES
    Run as Administrator.
    Review the commands before execution.
    Verify settings via `auditpol /get /category:*` after running.
    These settings can generate significant log volume. Ensure adequate log size/retention.
    Consult the competition README for any specific audit requirements that may differ.
#>
param()

Write-Host "Configuring Advanced Audit Policies..." -ForegroundColor Yellow

$auditCommands = @(
    # Account Logon Category
    'auditpol /set /subcategory:"Credential Validation" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Kerberos Authentication Service" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Kerberos Service Ticket Operations" /success:enable /failure:enable',
    # Account Management Category
    'auditpol /set /subcategory:"User Account Management" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Computer Account Management" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Security Group Management" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Distribution Group Management" /success:enable /failure:enable', # Less critical but good practice
    'auditpol /set /subcategory:"Application Group Management" /success:enable /failure:enable', # Less critical but good practice
    # Logon/Logoff Category
    'auditpol /set /subcategory:"Logon" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Logoff" /success:enable /failure:enable', # Success often less critical than Logon
    'auditpol /set /subcategory:"Account Lockout" /failure:enable /success:enable', # Success shows unlocks
    'auditpol /set /subcategory:"IPsec Main Mode" /failure:enable', # Often noisy on success
    'auditpol /set /subcategory:"Special Logon" /success:enable', # Tracks high privilege logons
    # Object Access Category
    'auditpol /set /subcategory:"File System" /failure:enable', # Enable Success only if specific SACLs are configured
    'auditpol /set /subcategory:"Registry" /failure:enable', # Enable Success only if specific SACLs are configured
    'auditpol /set /subcategory:"Detailed File Share" /failure:enable', # Can be noisy
    # Policy Change Category
    'auditpol /set /subcategory:"Audit Policy Change" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Authentication Policy Change" /success:enable /failure:enable',
    # Privilege Use Category
    'auditpol /set /subcategory:"Sensitive Privilege Use" /success:enable /failure:enable', # Success can be noisy but useful
    'auditpol /set /subcategory:"Non Sensitive Privilege Use" /failure:enable', # Success usually too noisy
    # System Category
    'auditpol /set /subcategory:"System Integrity" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Security State Change" /success:enable /failure:enable',
    'auditpol /set /subcategory:"Security System Extension" /success:enable /failure:enable',
    'auditpol /set /subcategory:"System Event" /success:enable /failure:enable'
    # Process Tracking - Enable if needed for forensics (Event ID 4688)
    # 'auditpol /set /subcategory:"Process Creation" /success:enable /failure:enable' # Can be very noisy
)

foreach ($command in $auditCommands) {
    Write-Host "Executing: $command"
    try {
        Invoke-Expression $command
        Start-Sleep -Milliseconds 100 # Small delay
    } catch {
        Write-Warning "Failed to execute '$command'. Error: $($_.Exception.Message)"
    }
}

Write-Host "`nAudit policy configuration attempted." -ForegroundColor Green
Write-Host "Verify settings using 'auditpol /get /category:*'" -ForegroundColor Cyan
Write-Host "Consider enabling Command Line Auditing via GPO/Registry if needed." -ForegroundColor Cyan
