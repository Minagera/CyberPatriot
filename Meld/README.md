# Using Meld for CyberPatriot: A Baselining Guide

This guide explains the concept of baselining and how to use visual difference tools like **Meld** effectively within the CyberPatriot competition context. Baselining is a powerful technique for quickly identifying unauthorized changes on a potentially compromised system. This guide provides unique insights tailored for CP.

## What is Baselining?

Baselining involves comparing the current state of a system (the competition image) against a known reference point (the baseline). The differences highlighted often point directly to vulnerabilities, misconfigurations, or attacker actions.

## Why Baselining Works in CyberPatriot

CyberPatriot images are intentionally modified from a standard configuration. Baselining helps you rapidly spot these modifications:

-   **Reveals hidden changes:** Spots modified configuration files, added users/groups, changed permissions, new services, or scheduled tasks that might be missed by checklists alone.
-   **Identifies attacker actions:** Highlights files dropped by attackers (malware, scripts), persistence mechanisms added (run keys, cron jobs), or services misconfigured/added.
-   **Saves time:** Focuses attention directly on the *differences*, rather than manually checking every possible setting on the system. Allows prioritization based on suspicious changes.
-   **Finds subtle issues:** Can uncover unexpected changes in less common configuration files, scripts, or even binary files (though interpreting binary diffs is advanced).

## What Can Be Used as a Baseline?

1.  **Clean OS Install:** Comparing the competition image to a truly clean, updated version of the *exact same OS* (e.g., Ubuntu 22.04 vs Ubuntu 22.04). This is the most accurate but requires having a clean VM readily available.
2.  **Initial Scan Output:** Running audit scripts (`../Windows/Scripts/`, `../Linux/Scripts/`) *immediately* at the start of the competition (before making *any* changes) to capture the initial state (users, services, processes, tasks, ports, etc.). Then, run the same scripts later and compare the output. This detects changes made *during* the competition (e.g., by scoring engine interactions or delayed malware).
3.  **"Known Good" Configuration Files:** Comparing critical configuration files from the image (`sshd_config`, `sudoers`, registry exports) against trusted, secure templates or versions from a known-good source.
4.  **Checklist as Baseline:** While not using Meld directly, comparing system settings against a comprehensive checklist (`../Checklists/`) is a form of conceptual baselining.

## Using Meld: The Workflow

Meld is a free, cross-platform visual diff and merge tool. (Download from [https://meldmerge.org/](https://meldmerge.org/))

**General Steps:**

1.  **Generate Baseline Data:** On your clean VM or immediately upon starting the competition image, run audit scripts or commands to capture system state. Save the output to clearly named text files (e.g., `baseline_users.txt`, `baseline_services.txt`).
    ```bash
    # Linux Example
    getent passwd > baseline_users.txt
    sudo systemctl list-units --type=service --state=running > baseline_services.txt
    sudo ss -tulpn > baseline_ports.txt
    sudo find / -perm /6000 -type f -ls > baseline_suid.txt 2>/dev/null
    sudo crontab -l > baseline_user_cron.txt 2>/dev/null
    sudo cat /etc/crontab /etc/cron.*/* > baseline_system_cron.txt 2>/dev/null
    ```
    ```powershell
    # Windows Example
    Get-LocalUser | Out-File baseline_users.txt
    Get-Service | Where-Object {$_.Status -eq "Running"} | Out-File baseline_services.txt
    Get-NetTCPConnection -State Listen | Out-File baseline_ports.txt
    Get-ScheduledTask | Where-Object {$_.State -ne "Disabled"} | Out-File baseline_tasks.txt
    Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run" | Out-String | Out-File baseline_hklm_run.txt
    Get-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run" | Out-String | Out-File baseline_hkcu_run.txt
    ```
2.  **Generate Comparison Data:** On the competition image (either initially or after some time), run the *exact same* commands/scripts and save the output to different files (e.g., `current_users.txt`, `current_services.txt`).
3.  **Transfer Files:** Get both sets of files onto a machine where Meld is installed (e.g., your host machine, a dedicated analysis VM). This might involve shared folders, `scp`, copy-paste, etc. (Follow competition rules regarding data transfer).
4.  **Launch Meld:** Open Meld.
5.  **Select Comparison:** Choose "File comparison". Browse and select the two files you want to compare (e.g., `baseline_users.txt` and `current_users.txt`).
6.  **Analyze Differences:** Meld will highlight lines that are added (green), deleted (red), or changed (blue).
    -   **Added lines** in the `current_*.txt` often indicate unauthorized additions (users, services, tasks, files).
    -   **Deleted lines** might indicate required services being stopped or users removed.
    -   **Changed lines** indicate modifications to existing configurations (e.g., SSH config change, user group membership change).

## Practical CyberPatriot Examples using Meld

### Example 1: Finding Unauthorized Users/Groups
-   Compare `baseline_users.txt` vs `current_users.txt` (from `getent passwd` or `Get-LocalUser`). Extra lines = added users.
-   Compare `baseline_admins.txt` vs `current_admins.txt` (from `Get-LocalGroupMember -Group Administrators` or `grep sudo /etc/group`). Extra lines = unauthorized admins/sudoers.
-   Compare `baseline_uid0.txt` vs `current_uid0.txt` (from `awk -F: '($3 == 0)' /etc/passwd`). Look for new non-root UID 0 users.

### Example 2: Identifying Service/Port Changes
-   Compare `baseline_services.txt` vs `current_services.txt`. Extra running services might be malicious or unnecessary. Missing services might be required ones that were stopped.
-   Compare `baseline_ports.txt` vs `current_ports.txt`. New listening ports indicate new network services (potentially unauthorized).
-   Compare specific config files if possible (e.g., `baseline_sshd_config.txt` vs `current_sshd_config.txt`). Look for changes like `PermitRootLogin yes`.

### Example 3: Finding Persistence Mechanisms
-   Compare `baseline_tasks.txt` vs `current_tasks.txt` (Win). Look for new scheduled tasks.
-   Compare `baseline_hklm_run.txt` vs `current_hklm_run.txt` (Win Registry). Look for new entries. Repeat for HKCU.
-   Compare `baseline_user_cron.txt` vs `current_user_cron.txt` (Linux). Look for new user cron jobs. Repeat for system cron files.
-   Compare `baseline_suid.txt` vs `current_suid.txt` (Linux). Look for unexpected binaries with the SUID bit newly set.

## Tips for Effective Baselining in CP

-   **Speed is Key:** Have your baseline generation commands/scripts ready to run immediately.
-   **Be Consistent:** Use the exact same commands to generate baseline and current data.
-   **Clear Naming:** Name your output files clearly (e.g., `Win_Baseline_Services_Initial.txt`, `Win_Current_Services_MidComp.txt`).
-   **Focus on High-Value Targets:** Prioritize comparing users, services, listening ports, scheduled tasks, run keys, and cron jobs.
-   **Practice:** Practice the entire workflow (generate data, transfer, use Meld) during training sessions.
-   **Combine with Checklists:** Use baselining to quickly find *what* changed, then use checklists and guides to understand *how* to fix it securely.

---
*This unique guide provides a CyberPatriot-focused approach to baselining using tools like Meld. Mastering this technique can significantly speed up vulnerability discovery.*
