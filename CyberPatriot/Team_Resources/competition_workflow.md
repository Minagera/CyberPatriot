# Detailed Competition Workflow

*(Note: This provides a more detailed breakdown compared to incident_response_workflow.md. Teams may choose to use or merge elements from both.)*

## Phase 1: Initial Setup & Reconnaissance (First 30-60 mins)

1.  **Start Timer!**
2.  **Access Image & Documentation:** Log in, locate the README file immediately.
3.  **READ THE README:** (Team Lead/Designated Reader) Read aloud or distribute key points:
    *   Scenario background
    *   Authorized users/groups
    *   Required services/applications
    *   Prohibited actions & penalties
    *   Forensic questions (Assign someone to start looking!)
    *   Scoring hints
4.  **Assign Initial Tasks:** Based on README and roles (e.g., Win Specialist starts user audit, Lin Specialist checks services, Cisco Specialist opens PT, Forensics Lead starts searching).
5.  **Initial System Scan (All Platforms):**
    *   Check running processes/services (`tasklist`/`ps`, `services.msc`/`systemctl`). Any obvious malware/unusual items?
    *   Check network connections (`netstat -ano`). Any suspicious outbound connections?
    *   Check logged-in users (`query user`/`who`).
6.  **Answer Obvious Forensics Questions:** If any answers are immediately apparent from the README or initial scan, document them.

## Phase 2: User & Security Baseline (Next 60-90 mins)

7.  **User Account Audit (Win/Lin):**
    *   Identify ALL users/groups.
    *   Compare against Authorized list from README.
    *   Remove/disable unauthorized users.
    *   Check admin/sudo group membership, remove unauthorized.
    *   Change ALL passwords (including required users) to strong ones. Document them securely.
    *   Disable Guest account.
8.  **Apply Critical Security Policies (Win/Lin):**
    *   Password Policy (Length, Complexity, History, Age).
    *   Account Lockout Policy.
    *   Basic Audit Policy (Logon Success/Failure).
9.  **Check/Enable Core Security Features (Win/Lin):**
    *   Windows Defender Antivirus (Enabled, Updated if possible).
    *   Windows Firewall (Enabled - All Profiles).
    *   Linux UFW (Enabled, Default Deny In, Allow required services - SSH, HTTP, etc.).
10. **Cisco Basic Hardening:**
    *   Hostname, Enable Secret, Console/VTY Passwords & Timeout, Banner, Encrypt Passwords.
    *   Configure SSH, Disable Telnet.
    *   Save Config (`copy run start`).

## Phase 3: Service Hardening & Persistence Removal (Next 60-90 mins)

11. **Service Audit & Hardening (Win/Lin):**
    *   Identify unnecessary/insecure services (Telnet, Remote Registry, SNMP, FTP unless required).
    *   Disable them (`services.msc`/`systemctl disable --now`).
    *   Check configurations of required services (e.g., SSH `sshd_config`, Apache `httpd.conf`). Apply hardening.
12. **Application Audit (Win/Lin):**
    *   Uninstall unauthorized software (Games, P2P, Hacking Tools).
    *   Check browser extensions.
13. **Persistence Hunt (Win/Lin):**
    *   Check Startup items (Task Mgr, Registry Run Keys, Startup Folders).
    *   Check Scheduled Tasks (`taskschd.msc`/`crontab -l`, `/etc/cron.*`).
    *   Check for SUID/SGID issues (Linux `find`).
    *   Check file permissions (world-writable files/dirs).
14. **Cisco Advanced Config:**
    *   Implement ACLs as required by README.
    *   Configure Port Security / VLANs if applicable.
    *   Disable unused interfaces.
    *   Save Config.

## Phase 4: Forensics & Final Review (Last 60 mins)

15. **Dedicated Forensics Search:** Focus on finding answers to remaining questions (Logs, File System, History, Registry). Use `find`/`grep`/Event Viewer filters.
16. **System Updates (Optional):** If allowed and time permits, run Windows Update / `apt upgrade`. *Caution: Can take time and potentially break things.*
17. **Review Checklists:** Go through platform checklists (`../Checklists/`) to ensure major items haven't been missed.
18. **Verify Scoring Engine:** Check the scoring report frequently. Did any changes cause point loss? Troubleshoot if necessary (refer to change log).
19. **Documentation Review:** Ensure change log is complete. Ensure forensic answers are documented with evidence.
20. **Final Configuration Saves (All Platforms):** `copy run start` on Cisco!
21. **Final Sanity Check:** Are required services still running? Can authorized users log in?

## Throughout Competition:

-   **Communicate:** Use SITREP/BLOCKER protocols.
-   **Document:** Use Change Log template.
-   **Manage Time:** Pace yourselves according to the phase estimates (adjust as needed).
-   **Check Score:** Monitor points gained/lost.

---
*Adapt this workflow based on team strengths and specific competition dynamics.*
