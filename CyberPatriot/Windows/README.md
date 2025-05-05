# Windows Security Training Materials (25-26 Season)

This directory centralizes resources for mastering Windows security within the CyberPatriot competition context, focusing on Windows 10/11 and potentially Windows Server editions.

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Contains `Basic/` and `Advanced/` guides covering fundamental concepts (User Management, Permissions, Basic Tools) to more complex topics (Registry, GPO, Auditing, Advanced Forensics). **Uniquely tailored for CP scenarios.**
-   [**Checklists/**](../Checklists/Windows/README.md)
    *   **Link to the main Windows checklist.** Provides a rapid hardening workflow, emphasizing README priority and actionable steps.
-   [**Exercises/**](../Exercises/Windows/README.md) (Create if missing)
    *   Hands-on labs and scenarios specifically designed to practice Windows hardening, vulnerability remediation, and forensic investigation skills.
-   [**Scripts/**](Scripts/README.md)
    *   Unique PowerShell scripts for automating security auditing (users, services, startup items, policies) and potentially safe, targeted configuration checks relevant to CyberPatriot. **Focus on reconnaissance and verification.**
-   [**VM-Setup/**](VM-Setup/README.md)
    *   Crucial resources for creating compromised Windows VM environments (`enterprise-workstation-setup.ps1`) simulating realistic CyberPatriot incident response challenges.

---

## CyberPatriot Competition Tips for Windows (Unique Focus)

-   **README is LAW:** Always start by dissecting the competition README. It dictates authorized users/services, prohibited actions, scoring tasks, and forensic clues. **It overrides generic best practices.** Document required items immediately.
-   **User Account Hygiene:** Prioritize identifying and removing unauthorized accounts (check `lusrmgr.msc`, `net user`, PowerShell). Secure *all* remaining accounts with strong, unique passwords (document them!). Disable the Guest account (SID S-1-5-32-546). Rename Admin/Guest *only if* README allows. Scrutinize `Administrators` and `Remote Desktop Users` group memberships relentlessly. Apply Least Privilege.
-   **Policy Enforcement (`secpol.msc` / GPO):** Configure robust Password Policies (length, complexity, history, age), Account Lockout Policies, and detailed Audit Policies (Logon Success/Failure, Account Management Success/Failure are critical). Set appropriate User Rights Assignments (deny Guest network/local/RDP logon). Configure Security Options (UAC enabled, NTLMv2 only, logon banner).
-   **Windows Security Stack:** Ensure Windows Defender Antivirus is active, updated (if possible), and consider running a quick scan. Verify Windows Defender Firewall is enabled for ALL profiles (Domain, Private, Public) with default inbound block. Carefully review/create rules based *only* on README requirements.
-   **Service & Application Control:** Disable unnecessary/risky services (`services.msc`, `Get-Service` - e.g., Telnet, Remote Registry, Fax) *after* confirming they aren't required by the README. Uninstall unauthorized software (games, P2P, hacking tools unless permitted, unknown apps) via Settings > Apps or `Get-Package`. Investigate services with suspicious paths or descriptions.
-   **Persistence Hunting:** Actively hunt for malware persistence: Registry Run/RunOnce keys (HKLM/HKCU `Software\Microsoft\Windows\CurrentVersion\Run`), Scheduled Tasks (`taskschd.msc`, `schtasks`), Startup Folders (User/All Users), malicious/hijacked Services, WMI event subscriptions (advanced).
-   **File System & Shares:** Review NTFS permissions on critical directories (`C:\Windows`, `C:\Users`). Remove overly permissive access (e.g., `Everyone`, `Users` Full Control). Check Network Shares (`fsmgmt.msc`, `Get-SmbShare`), remove unnecessary ones, and secure required shares with specific Share/NTFS permissions (Least Privilege). Disable SMBv1 if allowed (`Disable-WindowsOptionalFeature`). Check `C:\Windows\System32\drivers\etc\hosts` for redirects.
-   **Forensic Investigation:** Treat forensic questions as high-priority. Search common locations (Desktop, Docs, Downloads, Temp, Recycle Bin) and user profiles. Analyze Event Logs (`eventvwr.msc`) filtering by time, Event IDs (4624/25 Logon, 4720 User Create, 4732 Group Add, 7045 Service Install, 4688 Process Create w/ Command Line auditing enabled), and keywords from questions. Use `findstr` or `Select-String` for file content searches.
-   **Documentation & Verification:** Maintain a meticulous Change Log (`../Resources/Templates/Change_Log_Template.md`). Regularly check the scoring engine to confirm points awarded/lost after changes. Use documentation to revert harmful changes.
-   **Baselining:** Where feasible, use PowerShell commands (`Get-LocalUser`, `Get-Service`, `schtasks /query`, `Get-ItemProperty` for Run keys) at the *start* to capture an initial state. Compare later outputs or use Meld to spot differences quickly.

---
*All materials are uniquely developed for Grissom JROTC CyberPatriot. Use READMEs in subdirectories for specifics.*
