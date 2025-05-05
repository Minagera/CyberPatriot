# Windows Security Training Materials

This directory contains unique training materials specifically designed for securing Windows systems (Windows 11/Server focus) within the context of the CyberPatriot competition. The emphasis is on incident response, hardening, and forensic analysis.

**Always start by reading the README file in each subdirectory.**

## Directory Index

-   [**Checklists/**](Checklists/README.md)
    *   Actionable checklists for quickly securing Windows systems during competition, covering users, policies, services, firewall, and more.
-   [**Exercises/**](Exercises/README.md)
    *   Hands-on practice scenarios simulating common Windows vulnerabilities and misconfigurations found in CyberPatriot.
-   [**Guides/**](Guides/README.md)
    *   Detailed guides covering fundamental and advanced Windows security topics, tools, and techniques relevant to the competition. Organized into Basic and Advanced sections.
-   [**Quizzes/**](Quizzes/README.md)
    *   Quizzes to test understanding of Windows security fundamentals and system hardening techniques, mirroring the types of knowledge needed for CyberPatriot. (Links to main Quizzes directory)
-   [**Scripts/**](Scripts/README.md)
    *   Unique PowerShell scripts for automating common security checks, auditing tasks (users, services, startup items), and potentially safe hardening procedures specific to CyberPatriot scenarios.
-   [**VM-Setup/**](VM-Setup/README.md)
    *   Provides scripts (`enterprise-workstation-setup.ps1`) and documentation for creating compromised Windows virtual machine environments for incident response training, simulating the core CyberPatriot competition experience.

---

## CyberPatriot Competition Tips for Windows

-   **Read the README:** Always start by thoroughly reading the competition README file. It contains critical information about required services, authorized users, prohibited actions, and forensic questions. *It overrides general best practices.*
-   **User Accounts:** Focus on removing unauthorized users, securing existing accounts (especially administrators), disabling the Guest account, and enforcing strong password policies via Local Security Policy (`secpol.msc`) or GPO. Check group memberships carefully (Administrators, Remote Desktop Users).
-   **Security Policies:** Configure Local Security Policy (`secpol.msc`) settings for passwords, account lockout, auditing (enable success/failure for Logon Events, Policy Change, Object Access, Privilege Use), user rights assignment (limit risky rights), and security options (UAC, interactive logon messages).
-   **Windows Features:** Ensure Windows Defender Antivirus is active, updated, and running scans. Ensure Windows Defender Firewall is enabled and configured correctly for all profiles (Domain, Private, Public) - block unnecessary inbound connections. Apply necessary Windows Updates if network access is permitted and time allows.
-   **Services & Applications:** Disable unnecessary/risky services (e.g., Remote Registry, Telnet, SNMP) via `services.msc` and uninstall unauthorized applications or prohibited software (e.g., games, hacking tools, unauthorized remote access tools) via Settings > Apps. Check service permissions and recovery options.
-   **File System & Shares:** Review permissions on critical directories (e.g., `C:\Windows`, `C:\Program Files`). Check network shares (`compmgmt.msc` -> Shared Folders) and remove unnecessary shares or overly permissive access (like 'Everyone'). Disable SMBv1 (`Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`).
-   **Persistence:** Hunt for malware persistence mechanisms: Registry Run keys (HKLM/HKCU `Software\Microsoft\Windows\CurrentVersion\Run`), Scheduled Tasks (`taskschd.msc`), Startup Folders, malicious Services.
-   **Forensics:** Carefully search Desktop, Documents, Downloads, and common system locations (`C:\Users`, `C:\Windows\Temp`) for answers to forensic questions, often hidden in text files, images, or system configurations/logs. Check Event Viewer (`eventvwr.msc`) for relevant logs (Security - Event ID 4624/4625 for logons, System, Application).
-   **Documentation:** Keep a clear log of all changes made (user added/removed, service disabled, policy changed, software removed). Use templates from `../Resources/Templates/`. This helps troubleshoot if something breaks and aids in answering forensic questions.
-   **Baselining:** If possible, compare running processes (`tasklist`), services (`Get-Service`), scheduled tasks (`schtasks`), and startup items (`Get-CimInstance Win32_StartupCommand`) against a known-good baseline or initial scan.

---

*All materials in this directory are unique and designed for CyberPatriot training. Use the README files within each subdirectory for more specific guidance.*
