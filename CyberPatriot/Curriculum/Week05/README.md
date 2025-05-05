# Week 5: Windows System Hardening (Policies, Services, Firewall)

## Learning Objectives

By the end of this week, cadets will be able to:
-   Configure key security settings using Local Security Policy (`secpol.msc`), including Audit Policy and User Rights Assignment.
-   Analyze and manage Windows Services (`services.msc`), disabling unnecessary or insecure services according to the README.
-   Configure Windows Defender Firewall (`wf.msc`) for different network profiles, creating basic inbound/outbound rules.
-   Verify Windows Defender Antivirus status and perform basic scans.
-   Identify and remove unauthorized applications.

## Topics Covered

-   **Local Security Policy (`secpol.msc`) Deep Dive:**
    -   Audit Policy: Enabling logging for key events (Logon Success/Failure, Policy Change, Object Access, Privilege Use). Importance for forensics.
    -   User Rights Assignment: Restricting potentially dangerous rights (e.g., Debug programs, Act as part of OS, Take ownership). Granting necessary rights (e.g., Allow log on through RDP - *if required*). Denying rights (e.g., Deny log on locally/remotely for Guest).
    -   Security Options: Setting logon banners, disabling anonymous enumeration, configuring UAC behavior (ensure enabled), renaming Admin/Guest accounts (if allowed).
-   **Windows Services (`services.msc`, `Get-Service`):**
    -   Understanding Service states (Running, Stopped), Startup types (Automatic, Manual, Disabled).
    -   Identifying potentially risky services (e.g., Telnet, Remote Registry, unneeded web servers - *check README*).
    -   Disabling services: Changing startup type and stopping the service.
    -   Investigating suspicious services (checking path, dependencies, logon account).
-   **Windows Defender Firewall (`wf.msc`, `Get-NetFirewallProfile`):**
    -   Understanding profiles (Domain, Private, Public).
    -   Enabling/Disabling the firewall per profile.
    -   Configuring default inbound/outbound actions (Block/Allow).
    -   Viewing existing rules. Identifying potentially malicious rules.
    -   Creating basic inbound/outbound rules (Program, Port). *Crucial: Allow traffic required by README.*
-   **Windows Defender Antivirus (`Windows Security` App, PowerShell `Get-MpComputerStatus`):**
    -   Verifying Real-time protection is enabled.
    -   Checking definition update status.
    -   Running Quick/Full scans. Reviewing threat history.
-   **Application Security (`Settings > Apps`, `Get-Package`):**
    -   Identifying installed applications.
    -   Uninstalling unauthorized or prohibited software (games, P2P, hacking tools - *check README*).

## Activities/Exercises

-   **Lab 1 (secpol.msc):** Configure Audit Policy settings. Restrict specific User Rights (e.g., remove Users from "Allow log on locally" - observe effect). Set a security banner.
-   **Lab 2 (Services):** Identify potentially unnecessary services on a VM. Practice disabling a safe service (e.g., Print Spooler if no printing needed). Discuss how to research unknown services.
-   **Lab 3 (Firewall):** Ensure firewall is enabled for all profiles. Block all inbound connections by default. Create a rule to allow inbound traffic for a specific required application or port (e.g., port 80 for a web server if required by README).
-   **Lab 4 (Defender/Apps):** Verify Defender status. Run a quick scan. Find and uninstall an unauthorized application.
-   **Exercise:** [Unique Windows Hardening Exercise](../Exercises/Windows/Hardening/README.md) - Given a Windows VM and a mock README, configure specific policies, disable listed services, set firewall rules, verify Defender, and remove unauthorized software.

## Assessment

-   Participation in labs and configuration tasks.
-   Completion of [Unique Windows Hardening Exercise](../Exercises/Windows/Hardening/README.md).
-   [Unique Windows System Hardening Quiz](../Quizzes/Quiz-Files/Windows_System_Hardening_Quiz.md)

## Resources

-   [Unique Windows Hardening Guide](../Windows/Guides/Hardening/README.md) (Covers Policies, Services, Firewall, Defender)
-   [Unique Windows Checklist](../Checklists/Windows/README.md)
-   [Unique Windows Command Reference](../Resources/References/Windows_Security_Reference.md)
-   Microsoft documentation on `secpol.msc`, `services.msc`, `wf.msc`.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
