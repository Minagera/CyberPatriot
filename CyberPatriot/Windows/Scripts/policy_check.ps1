<#
.SYNOPSIS
    Checks key Windows Local Security Policy settings against recommended values.
.DESCRIPTION
    This script audits critical security policy settings like Password Policy and
    Account Lockout Policy by querying the local security database. It compares
    current settings against common CyberPatriot recommendations and flags deviations.

    Note: This script reads policy settings but does not change them.
    Requires Administrator privileges.
.NOTES
    Author: GitHub Copilot (Placeholder)
    Date:   [Current Date]
    Requires: PowerShell 5.1 or later. Run as Administrator.
              Relies on parsing output from secedit.exe. May be fragile if output format changes.
.EXAMPLE
    .\policy_check.ps1
#>

Write-Host "Starting Local Security Policy Audit..." -ForegroundColor Yellow
Write-Warning "This script checks common policies. Always verify against the competition README."

# Define recommended settings (adjust as needed based on common CP requirements)
$RecommendedSettings = @{
    # Password Policy
    "MinimumPasswordLength" = 12 # Example: Recommend 12 or more
    "PasswordComplexity" = 1     # 1 = Enabled
    "MinimumPasswordAge" = 1      # Example: Recommend 1 day
    "MaximumPasswordAge" = 60     # Example: Recommend 60 days
    "PasswordHistorySize" = 5    # Example: Remember last 5
    "ClearTextPassword" = 0      # 0 = Disabled (Store passwords using reversible encryption)

    # Account Lockout Policy
    "LockoutBadCount" = 5      # Example: Lockout after 5 attempts
    "LockoutDuration" = 30     # Example: Lockout for 30 minutes
    "ResetLockoutCount" = 30   # Example: Reset counter after 30 minutes

    # Other Security Options (Examples - Use registry checks for more reliability if needed)
    # "EnableGuestAccount" = 0 # 0 = Disabled (Check via Get-LocalUser)
    # "DontDisplayLastUserName" = 1 # 1 = Enabled
    # "LegalNoticeText" = "SET" # Check if text is set (not empty)
    # "LegalNoticeCaption" = "SET" # Check if caption is set
}

# Export current security policy to a temporary file
$TempFile = Join-Path $env:TEMP "security_policy_export.inf"
Write-Host "Exporting current security policy to $TempFile..."
secedit.exe /export /cfg $TempFile /quiet
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to export security policy using secedit.exe. Ensure you are running as Administrator."
    exit 1
}

# Read and parse the exported policy file
Write-Host "Parsing exported policy..."
try {
    $PolicyContent = Get-Content $TempFile -ErrorAction Stop
    Remove-Item $TempFile -Force -ErrorAction SilentlyContinue # Clean up temp file
} catch {
    Write-Error "Failed to read or delete temporary policy file '$TempFile'. Error: $($_.Exception.Message)"
    exit 1
}

# Find the System Access section (adjust if INF structure changes)
$SystemAccessSection = $PolicyContent | Select-String -Pattern '\[System Access\]' -Context 0, 20 # Get section header and lines after
if (-not $SystemAccessSection) {
    Write-Warning "Could not find [System Access] section in exported policy. Policy check may be incomplete."
    # Attempt to find other sections if needed, e.g., [Security Options]
}

# Function to parse a specific policy value
function Get-PolicyValue {
    param(
        [string]$PolicyName,
        [System.String[]]$PolicyLines
    )
    $Line = $PolicyLines | Select-String -Pattern "^$PolicyName\s*=\s*(.*)" -CaseSensitive
    if ($Line -and $Line.Matches.Groups.Count -ge 2) {
        return $Line.Matches.Groups[1].Value.Trim()
    } else {
        return $null # Not found or couldn't parse
    }
}

# Check each recommended setting
Write-Host "`nComparing current settings to recommendations:" -ForegroundColor Cyan
Write-Host "---------------------------------------------"
foreach ($SettingName in $RecommendedSettings.Keys) {
    $CurrentValue = Get-PolicyValue -PolicyName $SettingName -PolicyLines $SystemAccessSection.Line # Adjust context/section if needed
    $RecommendedValue = $RecommendedSettings[$SettingName]

    Write-Host "Policy: $SettingName"
    Write-Host "  Recommended: $RecommendedValue"

    if ($CurrentValue -ne $null) {
        Write-Host "  Current: $CurrentValue"
        # Basic comparison - adjust logic for specific policies (e.g., length >= recommended)
        if ($SettingName -eq "MinimumPasswordLength") {
             if ([int]$CurrentValue -lt [int]$RecommendedValue) {
                 Write-Warning "  *** Current value is LESS than recommended! ***"
             } else {
                 Write-Host "  Status: OK" -ForegroundColor Green
             }
        } elseif ($CurrentValue -ne $RecommendedValue) {
            Write-Warning "  *** Current value does not match recommendation! ***"
        } else {
            Write-Host "  Status: OK" -ForegroundColor Green
        }
    } else {
        Write-Warning "  *** Could not determine current value for $SettingName! ***"
    }
     Write-Host "---------------------------------------------"
}

# Clean up temp file if it still exists (e.g., due to script error)
if (Test-Path $TempFile) {
    Remove-Item $TempFile -Force -ErrorAction SilentlyContinue
}

Write-Host "Local Security Policy Audit Complete." -ForegroundColor Green
