# Windows Security Hardening Exercise

## Scenario

Following a basic security review, you must now harden a Windows workstation according to company policy and security best practices.

## Objectives

-   Configure comprehensive password and account lockout policies.
-   Enable and configure basic audit policies.
-   Harden system services.
-   Configure Windows Firewall rules.
-   Review and secure scheduled tasks and startup items.
-   Apply specific security options via Local Security Policy.

## Tasks

1.  **Policy Hardening (`secpol.msc`):**
    *   Configure Password Policy: Enforce history (5), Max age (60 days), Min age (1 day), Min length (12), Complexity (Enabled), Reversible encryption (Disabled).
    *   Configure Account Lockout Policy: Threshold (5 invalid attempts), Lockout duration (30 minutes), Reset counter (30 minutes).
    *   Configure Audit Policy (Local Policies > Audit Policy): Audit account logon events (Success, Failure), Audit logon events (Success, Failure), Audit policy change (Success, Failure), Audit system events (Success, Failure).
    *   Configure Security Options (Local Policies > Security Options): Set "Interactive logon: Message text/title for users attempting to log on", Disable "Accounts: Guest account status", Enable "User Account Control: Run all administrators in Admin Approval Mode".
2.  **Service Hardening (`services.msc`):**
    *   Identify the following services: Remote Registry, Telnet, SNMP Service.
    *   If found, disable these services (set Startup Type to Disabled and Stop the service if running).
3.  **Firewall Configuration (`wf.msc`):**
    *   Ensure the Firewall is enabled for Domain, Private, and Public profiles.
    *   Create a new Inbound Rule to Block incoming traffic on TCP Port 3389 (Remote Desktop), unless RDP is explicitly required by the scenario README.
4.  **Startup & Scheduled Tasks Review:**
    *   Use Task Manager (Startup tab) or Sysinternals Autoruns to review programs starting automatically. Identify any suspicious entries.
    *   Open Task Scheduler (`taskschd.msc`) and review active tasks. Look for tasks running with high privileges or executing suspicious scripts/programs. Disable any unauthorized tasks found.
5.  **Registry Check (Optional - Advanced):**
    *   Use `regedit.exe` to check common Run keys for unauthorized startup entries (e.g., `HKLM\Software\Microsoft\Windows\CurrentVersion\Run`, `HKCU\Software\Microsoft\Windows\CurrentVersion\Run`).

## Deliverables

-   Confirmation of policy settings applied.
-   List of services disabled.
-   Description of firewall rule created.
-   List of suspicious startup items or scheduled tasks identified/disabled.

## Hints

-   Refer to the Windows Checklist and Guides for specific policy locations and recommended settings.
-   Be cautious when disabling tasks or services; ensure they are not required for system operation or scoring.

*(This is a placeholder exercise. Content should be expanded with more specific details and potentially a corresponding VM setup.)*
