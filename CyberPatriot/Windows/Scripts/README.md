# Windows Security Scripts for CyberPatriot

This directory contains unique PowerShell scripts designed for automating security checks, hardening, auditing, and inventory tasks commonly needed in CyberPatriot competitions on Windows systems.

**Disclaimer:** Always understand what a script does before running it, especially in a competition environment. Test scripts thoroughly on practice VMs first. Incorrect script usage can break system functionality or lead to point deductions.

## Example Scripts

-   [**`user_audit.ps1`**](user_audit.ps1): Lists all local users, their status (enabled/disabled), last logon time (if available), and group memberships, highlighting administrative accounts.
-   [**`service_hardening.ps1`**](service_hardening.ps1): Identifies and offers to disable common non-essential or potentially risky services (e.g., Remote Registry, Telnet, SNMP). *Requires careful review before running.*
-   [**`defender_update.ps1`**](defender_update.ps1): Checks the status of Windows Defender Antivirus (Real-time protection, signature version) and attempts to trigger an update.
-   [**`firewall_check.ps1`**](firewall_check.ps1): Displays the status (enabled/disabled) of Windows Defender Firewall for Domain, Private, and Public profiles and lists currently allowed rules (can be verbose).
-   [**`startup_audit.ps1`**](startup_audit.ps1): Lists programs configured to run at startup (Registry Run keys, Startup folder) and enumerates active scheduled tasks for review.
-   [**`policy_check.ps1`**](policy_check.ps1): (Optional - Example) Checks key Local Security Policy settings (Password Policy, Lockout Policy) against recommended values.
-   [**`share_audit.ps1`**](share_audit.ps1): (Optional - Example) Lists active network shares and their permissions.

## How to Use

1.  Transfer the script to the target Windows machine.
2.  Open PowerShell as Administrator.
3.  Set the execution policy if necessary (e.g., `Set-ExecutionPolicy RemoteSigned -Scope Process -Force`).
4.  Navigate to the script directory (`cd C:\path\to\scripts`).
5.  Run the script (e.g., `.\user_audit.ps1`).
6.  Review the output carefully.

## Contribution

Develop new scripts for common CyberPatriot tasks (e.g., checking specific registry keys, auditing permissions, finding large media files). Ensure scripts are well-commented and focus on information gathering or safe configuration changes.

---

*All scripts are unique and designed for CyberPatriot training. Add new scripts as needed for your team! Always test scripts in a safe environment before using them in competition.*
