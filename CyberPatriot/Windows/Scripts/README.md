# Windows Security Scripts for CyberPatriot (PowerShell)

This directory contains unique PowerShell scripts designed to aid in auditing and reconnaissance during CyberPatriot competitions. **These scripts prioritize information gathering and verification over making direct system changes.**

**Disclaimer:** Always understand what a script does before running it, especially in a competition environment. Test scripts thoroughly in practice VMs. Use scripts to augment, not replace, manual investigation and understanding. **Prioritize actions based on the README, not just script output.**

## Scripting Philosophy for CyberPatriot

-   **Read-Only First:** Prioritize scripts that gather information without making changes.
-   **Targeted Information:** Scripts should collect specific, relevant security data (users, services, tasks, etc.).
-   **Baseline-Friendly Output:** Format output consistently (e.g., sorted lists) to make comparison with `diff` tools (like Meld) easier.
-   **Efficiency:** Automate repetitive checks to save time.
-   **Safety:** Avoid commands that could disrupt required services or violate competition rules.

## Available Scripts (Examples - Create/Update as needed)

-   **`Audit-UsersAndGroups.ps1`** (Placeholder - Create if missing)
    *   *Purpose:* Gathers information about local users (enabled status, password policies) and key group memberships (Administrators, Remote Desktop Users). Provides a quick overview of account status.
    *   *Output:* Formatted console output summarizing user accounts and group members.
-   **`Check-CommonPersistence.ps1`** (Placeholder - Create if missing)
    *   *Purpose:* Checks common persistence locations like Registry Run/RunOnce keys, enabled Scheduled Tasks (basic properties), and Startup folders. Highlights potentially suspicious entries for manual review.
    *   *Output:* Lists entries found in common persistence locations.
-   **`Audit-Services.ps1`** (Placeholder - Create if missing)
    *   *Purpose:* Lists running services and services set to auto-start, optionally filtering for non-Microsoft services or showing service executable paths. Helps identify potentially unnecessary or suspicious services.
    *   *Output:* Formatted list of services with relevant details (Name, DisplayName, Status, StartMode, PathName).
-   **`Get-SystemInfoAudit.ps1`** (Placeholder - Create if missing)
    *   *Purpose:* Gathers basic system information (OS version, hostname, uptime), checks firewall status, UAC status, and Defender status. Provides a quick system health check.
    *   *Output:* Summary of key system and security feature statuses.

## How to Use

1.  Transfer the desired script(s) to the target Windows VM (ensure transfer method is secure and permitted).
2.  Open **PowerShell as Administrator**.
3.  Temporarily adjust execution policy if needed (use the least permissive scope necessary):
    ```powershell
    # Example: Allow scripts for this PowerShell session only
    Set-ExecutionPolicy RemoteSigned -Scope Process -Force
    ```
4.  Navigate to the script's directory: `cd C:\Path\To\Scripts`
5.  Run the script: `.\ScriptName.ps1`
6.  **Carefully review the output.** Use the information to guide your manual investigation and hardening actions based on the competition README.

## Contribution

Develop new scripts focusing on:
-   **Information Gathering:** Checking specific security settings (e.g., audit policy status, specific registry keys related to security features), finding prohibited files, checking share permissions.
-   **Non-Destructive Checks:** Scripts should avoid making changes unless explicitly designed for a safe, reversible configuration check (clearly documented).
-   **Clarity and Comments:** Ensure scripts are well-commented, explaining each section's purpose.
-   **Uniqueness:** Tailor scripts for common CyberPatriot findings and avoid simply copying generic scripts found online.

---
*All scripts are unique and designed for Grissom JROTC CyberPatriot training. Always test thoroughly before competition use.*
