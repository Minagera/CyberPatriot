# Week 9: Advanced Windows Security & Incident Response Intro

## Learning Objectives

By the end of this week, cadets will be able to:
-   Identify key Windows Registry hives and common persistence locations (Run keys).
-   Use Registry Editor (`regedit`) to view and potentially modify keys (with caution).
-   Configure and analyze Windows Event Logs (`eventvwr.msc`) for security events.
-   Identify common Windows persistence mechanisms (Scheduled Tasks, Startup Folders, Services).
-   Understand basic incident response concepts (Identification, Containment, Eradication, Recovery, Lessons Learned).
-   Apply learned techniques using `VM-Setup` scenarios.

## Topics Covered

-   **Windows Registry Overview:**
    -   Purpose: Hierarchical database storing configuration settings.
    -   Key Hives: HKLM (HKEY_LOCAL_MACHINE), HKCU (HKEY_CURRENT_USER), HKCR, HKU, HKCC.
    -   Registry Editor (`regedit`): Navigating, viewing keys/values. *Caution: Modifying registry can break the system.*
    -   Persistence Locations:
        -   Run/RunOnce Keys (HKLM/HKCU `\Software\Microsoft\Windows\CurrentVersion\Run`)
        -   Other potential locations (mention `RunOnce`, `Policies\Explorer\Run`, etc., but focus on main Run keys).
    -   Using PowerShell to query Run keys: `Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run'`, `Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run'`.
-   **Windows Event Logs (`eventvwr.msc`):**
    -   Key Logs: Security, System, Application.
    -   Enabling Auditing (Review from Week 5): Audit Policy (`secpol.msc`).
    -   Viewing and Filtering Logs: Filtering by Event ID, time range, keywords.
    -   Common Security Event IDs:
        -   4624: Successful Logon
        -   4625: Failed Logon
        -   4634: Logoff
        -   4688: Process Creation (Requires separate audit policy enablement)
        -   4720: User Account Created
        -   4722: User Account Enabled
        -   4725: User Account Disabled
        -   4726: User Account Deleted
        -   4732: User Added to Security Group (e.g., Administrators)
        -   7045: Service Installed
    -   Using logs for forensic questions.
-   **Windows Persistence Mechanisms (Review & Expansion):**
    -   Scheduled Tasks (`taskschd.msc`, `schtasks /query`): Look for suspicious tasks (unusual names, paths, triggers, run as SYSTEM).
    -   Startup Folders (User: `%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`, All Users: `%ProgramData%\Microsoft\Windows\Start Menu\Programs\Startup`).
    -   Malicious Services (`services.msc`): Services with suspicious paths, descriptions, or running malicious executables.
    -   Registry Run Keys (Covered above).
    -   (Mention others briefly: WMI Event Subscriptions, DLL Hijacking - advanced).
-   **Introduction to Incident Response (IR):**
    -   Lifecycle Phases (Simplified):
        1.  Preparation (Training, Tools - What we are doing now!)
        2.  Identification (Detecting the incident - Seeing scoring issues, finding malware/users)
        3.  Containment (Stopping the spread - Disabling accounts, firewall rules)
        4.  Eradication (Removing the root cause - Deleting malware, fixing configs)
        5.  Recovery (Restoring normal operations - Ensuring required services run)
        6.  Lessons Learned (Post-mortem/AAR - Improving for next time)
    -   Applying IR mindset to CyberPatriot: Identify -> Contain/Eradicate -> Recover (score points) -> Document (Lessons Learned).
-   **Practice with `VM-Setup`:**
    -   Using the `../VM-Setup/Windows/enterprise-workstation-setup.ps1` script to create compromised VMs.
    -   Applying investigation techniques (logs, registry, tasks, services) to find vulnerabilities and forensic answers described in the generated `README-Incident.txt`.

## Activities/Exercises

-   **Lab 1 (Registry):** Use `regedit` to navigate to HKLM/HKCU Run keys. Observe entries. Use PowerShell to query Run keys. (Optional: Add a harmless test value and remove it).
-   **Lab 2 (Event Logs):** Ensure logon auditing is enabled. Log in/out, fail a login. Use `eventvwr.msc` to find the corresponding Event IDs (4624, 4625, 4634). Filter logs by ID and time.
-   **Lab 3 (Persistence):** Use `taskschd.msc` to view scheduled tasks. Check startup folders. Review services for suspicious entries.
-   **Lab 4 (IR Discussion):** Discuss the IR lifecycle phases in the context of a typical CyberPatriot round. How do finding unauthorized users, disabling services, or fixing firewall rules fit in?
-   **Exercise:** [Unique Windows IR Scenario](../Exercises/Windows/Incident_Response/README.md) - Use a VM generated by `../VM-Setup/Windows/`. Follow the generated README, investigate using logs, registry, tasks, etc., to identify IOCs (Indicators of Compromise), remove persistence, and answer forensic questions.

## Assessment

-   Participation in labs and investigation tasks.
-   Ability to locate common persistence mechanisms.
-   Ability to filter and find basic security events in Event Viewer.
-   Completion of [Unique Windows IR Scenario](../Exercises/Windows/Incident_Response/README.md).
-   [Unique Incident Response Quiz](../Quizzes/Quiz-Files/Incident_Response_Quiz.md) (Focus on concepts and Windows specifics)

## Resources

-   [Unique Windows Persistence Guide](../Windows/Guides/Persistence/README.md) (New or enhance existing)
-   [Unique Windows Auditing/Logging Guide](../Windows/Guides/Auditing/README.md) (New or enhance existing)
-   [Unique Windows VM Setup README](../Windows/VM-Setup/README.md)
-   Microsoft documentation on Registry, Event Viewer, Scheduled Tasks.
-   NIST SP 800-61 (Computer Security Incident Handling Guide) - For reference on formal IR.

---
*This weekly plan is uniquely designed for the Grissom JROTC CyberPatriot program.*
