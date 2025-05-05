# Using Meld for CyberPatriot: A Baselining Guide

This guide explains how to use Meld, a visual diff and merge tool, as part of a baselining strategy for CyberPatriot competitions. Baselining is a powerful technique for quickly identifying unauthorized changes and vulnerabilities.

## What is Meld?

Meld is a graphical tool that helps you compare:
- Individual text files
- Entire directories
- Version-controlled projects (less relevant for basic CP baselining)

It highlights differences line-by-line or file-by-file, making it easy to spot modifications, additions, or deletions between two versions.

[Meld Website](https://meldmerge.org/) - Available for Linux, Windows, and macOS.

## Why Baselining Works in CyberPatriot

Baselining involves comparing the state of the competition image against a known-good baseline. This baseline could be:
1.  A clean, uncompromised version of the same operating system.
2.  Output from scanning/auditing scripts run immediately at the start of the competition *before* making changes.
3.  Documentation or checklists representing a secure configuration.

This approach is effective because it:
-   **Reveals hidden changes:** Spots modified configuration files, added users/groups, or changed permissions that might be missed by checklists alone.
-   **Identifies attacker actions:** Highlights files dropped by attackers, persistence mechanisms added, or services misconfigured.
-   **Saves time:** Focuses attention directly on the differences, rather than checking every possible setting.
-   **Finds subtle issues:** Can uncover unexpected changes in less common configuration files or scripts.

## How to Use Meld for Baselining

The core idea is to generate comparable text-based outputs from both the **Clean Baseline VM** and the **Competition Image VM**, then use Meld to compare these outputs.

### Step 1: Prepare Your Baseline
- Have a clean, updated VM of the OS typically used in competition (e.g., Ubuntu 22.04, Windows 10/11). Snapshot this clean state.
- Alternatively, run audit scripts *immediately* on the competition image before making changes and save the output as your "initial state" baseline.

### Step 2: Generate Output on Both VMs
Run commands or scripts on *both* the clean VM and the competition VM to capture system state. Save the output to text files with clear names (e.g., `clean_users.txt`, `comp_users.txt`).

**Example Outputs to Generate:**

**Linux:**
-   User list: `cat /etc/passwd | sort > users.txt`
-   Group list: `cat /etc/group | sort > groups.txt`
-   Sudoers: `sudo cat /etc/sudoers > sudoers.txt ; sudo ls /etc/sudoers.d/ > sudoers_d.txt`
-   Running Services: `systemctl list-units --type=service --state=running > running_services.txt`
-   Listening Ports: `sudo ss -tulpn > listening_ports.txt`
-   Cron jobs (system): `ls /etc/cron.* > cron_system.txt`
-   Cron jobs (user - run for relevant users): `crontab -l > user_cron.txt`
-   Installed Packages: `apt list --installed > installed_packages.txt`
-   SSH Config: `cat /etc/ssh/sshd_config > sshd_config.txt`
-   PAM Config (example): `cat /etc/pam.d/common-password > common-password.txt`
-   SUID Files: `sudo find / -perm /4000 -type f 2>/dev/null > suid_files.txt`

**Windows (PowerShell):**
-   Users: `Get-LocalUser | Format-List | Out-File users.txt`
-   Groups: `Get-LocalGroup | Format-List | Out-File groups.txt`
-   Admin Members: `Get-LocalGroupMember -Group Administrators | Format-List | Out-File admin_members.txt`
-   Running Services: `Get-Service | Where-Object {$_.Status -eq 'Running'} | Format-List | Out-File running_services.txt`
-   Firewall Rules (Enabled): `Get-NetFirewallRule -Enabled True | Format-List | Out-File firewall_rules.txt`
-   Scheduled Tasks: `Get-ScheduledTask | Format-List | Out-File scheduled_tasks.txt`
-   Registry Run Keys:
    ```powershell
    Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' | Out-File run_keys_hklm.txt
    Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' | Out-File run_keys_hkcu.txt
    # Add Wow6432Node paths if needed
    ```
-   Installed Programs: `Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-List | Out-File installed_programs.txt`

### Step 3: Transfer Output Files
Transfer the generated text files from both VMs to a single machine where Meld is installed (e.g., using shared folders, USB drive, or SCP). Organize them into `CleanOutput` and `CompOutput` directories.

### Step 4: Compare with Meld
1.  Open Meld.
2.  Choose "Directory comparison".
3.  Select the `CleanOutput` directory as the first directory and `CompOutput` as the second.
4.  Click "Compare".
5.  Meld will show files that are different, added, or removed.
6.  Double-click on a differing file (e.g., `users.txt`) to see a line-by-line comparison highlighting the changes (e.g., added unauthorized users).
7.  Analyze the differences to identify potential security issues or forensic clues.

## Practical CyberPatriot Examples

### Example 1: Finding Unauthorized Users
- Compare `users.txt` (Linux: `/etc/passwd`, Win: `Get-LocalUser`).
- Look for extra lines in the competition output = added users.
- Compare `admin_members.txt` (Win) or check UID 0 / sudo group membership differences (Linux).

### Example 2: Identifying Service Changes
- Compare `running_services.txt`.
- Extra services running on the competition image might be malicious or unnecessary.
- Missing services might indicate tampering or required services being stopped.
- Compare config files like `sshd_config.txt` for specific parameter changes (e.g., `PermitRootLogin yes`).

### Example 3: Finding Persistence Mechanisms
- Compare `scheduled_tasks.txt` (Win) or `user_cron.txt` / `cron_system.txt` (Linux). Look for new entries.
- Compare `run_keys_hklm.txt` / `run_keys_hkcu.txt` (Win). Look for new entries.
- Compare `suid_files.txt` (Linux). Look for unexpected binaries with the SUID bit set.

## Conclusion

Baselining with Meld (or similar diff tools like `diff` on Linux) is a powerful technique that complements traditional checklists. It helps you:
- Quickly pinpoint deviations from a known-good state.
- Identify attacker modifications and persistence.
- Focus remediation efforts effectively.
- Save valuable time during the competition.

Practice generating these outputs and using Meld to become proficient before competition day. Remember that the quality of your baseline determines the effectiveness of this strategy.
