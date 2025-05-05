<#
.SYNOPSIS
    Audits local user accounts and key group memberships on a Windows system.
    Designed for CyberPatriot information gathering and baselining.
    Outputs information to the console and optionally to files.

.DESCRIPTION
    This script performs the following actions:
    1. Lists all local user accounts with Enabled status.
    2. Lists members of the Administrators group.
    3. Lists members of the Remote Desktop Users group.
    4. (Optional) Outputs these lists to separate text files in a specified directory.

.PARAMETER OutputDir
    Optional. Specifies the directory path where output files will be saved.
    If not specified, output is only sent to the console.

.EXAMPLE
    .\audit_users.ps1
    # Displays user and group information on the console.

.EXAMPLE
    .\audit_users.ps1 -OutputDir C:\AuditOutput
    # Displays info on console and saves 'AllUsers.txt', 'AdminGroup.txt', 'RDPGroup.txt' to C:\AuditOutput.

.NOTES
    Author: GitHub Copilot (for Grissom JROTC CyberPatriot)
    Date:   [Current Date]
    Version: 1.0
    Requires: PowerShell 5.0 or later. Run as Administrator.
    Disclaimer: This script is for educational and CyberPatriot training purposes only.
                Review and test thoroughly before use. No warranty provided.
#>
param(
    [string]$OutputDir
)

# Function to safely create output directory if specified
function Ensure-OutputDir {
    if ($OutputDir) {
        if (-not (Test-Path -Path $OutputDir -PathType Container)) {
            try {
                New-Item -Path $OutputDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
                Write-Host "Created output directory: $OutputDir" -ForegroundColor Green
            } catch {
                Write-Error "Failed to create output directory: $OutputDir. $_"
                # Fallback to console output only
                $script:OutputDir = $null
            }
        }
    }
}

# Function to handle output (Console and optional File)
function Write-AuditOutput {
    param(
        [Parameter(Mandatory=$true)]
        [object]$Data,
        [string]$FileName
    )
    # Console Output
    $Data | Format-Table -AutoSize | Out-String | Write-Host

    # File Output (if OutputDir is set)
    if ($script:OutputDir -and $FileName) {
        $filePath = Join-Path -Path $script:OutputDir -ChildPath $FileName
        try {
            # Use Out-String to preserve Format-Table layout in file
            $Data | Format-Table -AutoSize | Out-String | Out-File -FilePath $filePath -Encoding UTF8 -ErrorAction Stop
            Write-Host "Output saved to: $filePath" -ForegroundColor Cyan
        } catch {
            Write-Error "Failed to write output to file: $filePath. $_"
        }
    }
}

# --- Main Script Logic ---

Write-Host "Starting Windows User Audit..." -ForegroundColor Yellow
Ensure-OutputDir

# 1. List All Local Users (Enabled/Disabled)
Write-Host "`n[+] All Local User Accounts:" -ForegroundColor Green
try {
    $allUsers = Get-LocalUser | Select-Object Name, Enabled, Description | Sort-Object Name
    Write-AuditOutput -Data $allUsers -FileName "AllUsers.txt"
} catch {
    Write-Error "Failed to get local users. $_"
}

# 2. List Administrators Group Members
Write-Host "`n[+] Administrators Group Members:" -ForegroundColor Green
try {
    $adminMembers = Get-LocalGroupMember -Group "Administrators" | Select-Object Name, PrincipalSource, ObjectClass | Sort-Object Name
    Write-AuditOutput -Data $adminMembers -FileName "AdminGroup.txt"
} catch {
    Write-Error "Failed to get Administrators group members. $_"
}

# 3. List Remote Desktop Users Group Members
Write-Host "`n[+] Remote Desktop Users Group Members:" -ForegroundColor Green
try {
    # Handle case where the group might not exist
    $rdpGroup = Get-LocalGroup -Name "Remote Desktop Users" -ErrorAction SilentlyContinue
    if ($rdpGroup) {
        $rdpMembers = Get-LocalGroupMember -Group "Remote Desktop Users" | Select-Object Name, PrincipalSource, ObjectClass | Sort-Object Name
        Write-AuditOutput -Data $rdpMembers -FileName "RDPGroup.txt"
    } else {
        Write-Host "Remote Desktop Users group not found." -ForegroundColor Yellow
    }
} catch {
    Write-Error "Failed to get Remote Desktop Users group members. $_"
}

# --- Add more checks as needed ---
# e.g., Check for users with password never expires, check other sensitive groups

Write-Host "`nWindows User Audit Complete." -ForegroundColor Yellow
