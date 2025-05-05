# Windows Security Training Materials

This directory contains all training materials related to securing Microsoft Windows systems (focusing on Windows 11 and recent Server versions) for the CyberPatriot competition.

## Directory Index

### [Checklists/](Checklists/README.md)
Links to the detailed Windows checklist in the main `Checklists/Windows/` directory. Emphasizes critical steps like user account management, security policy configuration, service hardening, and reviewing the competition README first.

### [Exercises/](Exercises/README.md)
Offers hands-on practice scenarios designed to simulate CyberPatriot challenges on Windows. Includes exercises for basic security tasks and more advanced system hardening.

### [Guides/](Guides/README.md)
Provides in-depth guides covering fundamental and advanced Windows security topics, including user management, Group Policy, registry hardening, and common competition scenarios.
-   **[Basic/](Guides/Basic/README.md)**: Covers foundational Windows security concepts.
-   **[Advanced/](Guides/Advanced/README.md)**: Explores more complex topics like registry security and advanced policy settings.

### [Quizzes/](Quizzes/README.md)
Includes quizzes to test understanding of Windows security fundamentals and system hardening techniques, mirroring the types of knowledge needed for CyberPatriot.

### [Scripts/](Scripts/README.md)
Contains unique PowerShell scripts for automating common security checks, auditing tasks, and hardening procedures specific to CyberPatriot scenarios.

### [VM-Setup/](VM-Setup/README.md)
Provides scripts and documentation for creating compromised Windows virtual machine environments for incident response training, simulating the core CyberPatriot competition experience.

---

## CyberPatriot Competition Tips for Windows

-   **Read the README:** Always start by thoroughly reading the competition README file. It contains critical information about required services, authorized users, prohibited actions, and forensic questions.
-   **User Accounts:** Focus on removing unauthorized users, securing existing accounts (especially administrators), disabling the guest account, and enforcing strong password policies via Local Security Policy or GPO.
-   **Security Policies:** Configure Local Security Policy (`secpol.msc`) settings for passwords, account lockout, auditing, user rights assignment, and security options according to best practices or README specifics.
-   **Windows Features:** Ensure Windows Defender Antivirus is active and updated, Windows Defender Firewall is enabled and configured correctly (check all profiles: Domain, Private, Public), and necessary Windows Updates are applied (if network access is permitted and time allows).
-   **Services & Applications:** Disable unnecessary/risky services (e.g., Remote Registry, Telnet, SNMP) via `services.msc` and uninstall unauthorized applications or prohibited software (e.g., games, hacking tools, unauthorized remote access tools) via Settings > Apps.
-   **File System & Shares:** Review permissions on critical directories (e.g., `C:\Windows`, `C:\Program Files`). Check network shares (`compmgmt.msc` -> Shared Folders) and remove unnecessary shares or overly permissive access (like 'Everyone'). Disable SMBv1 if possible.
-   **Forensics:** Carefully search Desktop, Documents, Downloads, and common system locations for answers to forensic questions, often hidden in text files, images, or system configurations/logs. Check Event Viewer (`eventvwr.msc`) for relevant logs (Security, System, Application).
-   **Documentation:** Keep a clear log of all changes made (user added/removed, service disabled, policy changed, software removed). This helps troubleshoot if something breaks and aids in report writing.
-   **Baselining:** If possible, compare running processes, services, scheduled tasks, and startup items against a known-good baseline.

---

*All materials in this directory are unique and designed for CyberPatriot training. Use the README files within each subdirectory for more specific guidance.*
