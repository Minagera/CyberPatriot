# Windows Security Training Materials

This directory provides unique training materials specifically focused on securing Windows environments (Windows 11, Windows Server) within the context of the CyberPatriot competition, emphasizing an incident response and remediation approach suitable for Nationals.

**Always start by reading the README file in each subdirectory.**

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Contains unique guides covering Basic, Intermediate, and Advanced Windows security concepts, tools (GUI and command-line), policy configuration, service hardening, registry analysis, PowerShell for security, and forensic techniques relevant to CyberPatriot.
-   [**Exercises/**](Exercises/README.md)
    *   Hands-on practice scenarios specifically designed for Windows, ranging from basic tasks to complex incident response simulations. Solutions or walkthroughs may be included for mentor reference.
-   [**Scripts/**](Scripts/README.md)
    *   Unique PowerShell scripts developed for auditing, information gathering, and potentially safe automation tasks common in CyberPatriot. Includes templates, examples, and potentially solutions/explanations.
-   [**Quizzes/**](Quizzes/README.md)
    *   Windows-specific quizzes (`Quiz-Files/`) and corresponding answer keys (`Solutions/`) for assessing cadet knowledge on Windows security topics.
-   [**VM-Setup/**](../VM-Setup/Windows/README.md) (Link to main VM-Setup section for Windows)
    *   Provides scripts (`enterprise-workstation-setup.ps1`) and documentation for creating compromised Windows virtual machine environments for incident response training, simulating the core CyberPatriot competition experience.

---

## Training Focus (Nationals Level)

-   **Incident Response:** Identifying unauthorized users, processes, services, scheduled tasks, registry changes (Run keys, etc.), and other persistence mechanisms.
-   **System Hardening:** Applying security policies (`secpol.msc`, GPO concepts), configuring Windows Defender Firewall, securing services, managing updates, enabling and reviewing audit logs.
-   **Forensic Analysis:** Using Event Viewer (`eventvwr.msc`), analyzing registry hives, examining file system artifacts, and leveraging PowerShell for investigation.
-   **Tool Proficiency:** Mastering built-in tools (`lusrmgr.msc`, `services.msc`, `taskschd.msc`, `regedit`, `wf.msc`, `eventvwr.msc`) and essential PowerShell cmdlets (`Get-LocalUser`, `Get-LocalGroupMember`, `Get-Service`, `Get-Process`, `Get-ScheduledTask`, `Get-NetFirewallRule`, `Get-WinEvent`).

## CyberPatriot Competition Tips for Windows

-   **Read the README:** Always start by thoroughly reading the competition README file. It contains critical information about required services, authorized users, prohibited actions, and forensic questions. *It overrides general best practices.*
-   **User Accounts:** Focus on removing unauthorized users, securing existing accounts (especially administrators), disabling the Guest account, and enforcing strong password policies via Local Security Policy (`secpol.msc`) or GPO. Check group memberships carefully (Administrators, Remote Desktop Users).
-   **Security Policies:** Configure Local Security Policy (`secpol.msc`) settings for passwords, account lockout, auditing (enable success/failure for Logon Events, Policy Change, Object Access, Privilege Use), user rights assignment (limit risky rights), and security options (UAC, interactive logon messages).
-   **Windows Features:** Ensure Windows Defender Antivirus is active, updated, and running scans. Ensure Windows Defender Firewall is enabled and configured correctly for all profiles (Domain, Private, Public) - block unnecessary inbound connections unless required by the README. Apply necessary Windows Updates if network access is permitted and time allows.
-   **Services & Applications:** Disable unnecessary/risky services (e.g., Remote Registry, Telnet, SNMP) via `services.msc` and uninstall unauthorized applications or prohibited software (e.g., games, hacking tools, unauthorized remote access tools) via Settings > Apps. Check service permissions and recovery options.
-   **File System & Shares:** Review permissions on critical directories (e.g., `C:\Windows`, `C:\Program Files`). Check network shares (`compmgmt.msc` -> Shared Folders) and remove unnecessary shares or overly permissive access (like 'Everyone'). Disable SMBv1 (`Disable-WindowsOptionalFeature -Online -FeatureName SMB1Protocol`).
-   **Persistence:** Hunt for malware persistence mechanisms: Registry Run keys (HKLM/HKCU `Software\Microsoft\Windows\CurrentVersion\Run`), Scheduled Tasks (`taskschd.msc`), Startup Folders, malicious Services.
-   **Forensics:** Carefully search Desktop, Documents, Downloads, and common system locations (`C:\Users`, `C:\Windows\Temp`) for answers to forensic questions, often hidden in text files, images, or system configurations/logs. Check Event Viewer (`eventvwr.msc`) for relevant logs (Security - Event ID 4624/4625 for logons, System, Application).
-   **Documentation:** Keep a clear log of all changes made (user added/removed, service disabled, policy changed, software removed). Use templates from `../Resources/Templates/`. This helps troubleshoot if something breaks and aids in answering forensic questions.
-   **Baselining:** If possible, compare running processes (`tasklist`), services (`Get-Service`), scheduled tasks (`schtasks`), and startup items (`Get-CimInstance Win32_StartupCommand`) against a known-good baseline or initial scan. Tools like Meld (`../Meld/`) can be invaluable.

---

*All materials in this directory are unique and designed for CyberPatriot training. Use the README files within each subdirectory for more specific guidance.*
