# Windows Forensics Challenge

## Scenario

A Windows workstation is suspected of being used by an unauthorized individual. Traces of their activity may exist within the system logs and file system. You need to investigate and answer specific questions about the activity.

## Objectives

-   Analyze Windows Event Logs to find evidence of specific events.
-   Search the file system for hidden or suspicious files.
-   Answer forensic questions based on findings.
-   Understand common locations for forensic artifacts.

## Forensic Questions (Example)

*(These questions would typically be provided within the exercise or a scenario README)*

1.  What is the username of the last user who successfully logged on via the console before [Timestamp]? (Requires Logon Event analysis)
2.  An unauthorized file named `secrets.txt` was downloaded. What directory was it saved in? (Requires file system search)
3.  A specific malicious process `evil.exe` was run. What time did it first execute according to the logs? (Requires Process Creation Event analysis - requires enabling Audit Process Creation)
4.  What is the IP address of the remote machine that attempted to connect via Remote Desktop (RDP) at [Timestamp]? (Requires RDP/Firewall/Security log analysis)
5.  A scheduled task named "UpdateChecker" was created by an attacker. What program does this task execute? (Requires Task Scheduler analysis)

## Tasks

1.  **Enable Necessary Auditing:** Ensure audit policies for Logon Events, Account Logon, Process Creation (if needed for specific questions), and Policy Change are enabled (Success and Failure). *Note: In a real competition, auditing might already be enabled or you might not have time/permission to change it.*
2.  **Event Log Analysis (`eventvwr.msc`):**
    *   Filter the Security log for relevant Event IDs (e.g., 4624 for successful logon, 4625 for failed logon, 4688 for process creation, 4720 for user creation).
    *   Search logs based on timestamps and keywords provided in the forensic questions.
3.  **File System Search:**
    *   Use File Explorer (ensure "Show hidden files, folders, and drives" and disable "Hide protected operating system files" are set in Folder Options) and the command line (`dir /a`, `findstr`).
    *   Search common locations: User profiles (Desktop, Documents, Downloads, AppData), Temp folders (`C:\Windows\Temp`, `%TEMP%`), Recycle Bin.
    *   Look for files matching names or types mentioned in questions.
4.  **Task Scheduler Review (`taskschd.msc`):**
    *   Examine tasks for suspicious names, triggers, actions, or authors.
5.  **Registry Review (`regedit.exe` - Optional):**
    *   Check Run keys, UserAssist key, or other relevant locations if suggested by questions.

## Deliverables

-   Answers to the specific forensic questions, citing the evidence found (e.g., Event ID, log entry details, file path).

## Hints

-   PowerShell can be very useful for filtering event logs (`Get-WinEvent`).
-   Sysinternals tools (Autoruns, Process Explorer, TCPView) can be helpful if allowed.
-   Timestamps are crucial; ensure system time is correct or account for discrepancies.

*(This is a placeholder exercise. Content requires specific forensic questions tailored to a scenario and potentially a corresponding VM setup with pre-planted artifacts.)*
