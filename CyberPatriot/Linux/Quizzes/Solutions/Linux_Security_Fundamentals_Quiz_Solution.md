# Linux Security Fundamentals Quiz - Solution Key (CyberPatriot Intermediate)

## Overview

This document provides the answers and explanations for the Linux Security Fundamentals Quiz (CyberPatriot Intermediate).

---

## Section 1: Multiple Choice (2 points each)

1.  **C. `/etc/shadow`**
    *   Explanation: Modern Linux systems store the encrypted (hashed) passwords in `/etc/shadow`, which has restricted permissions, rather than the world-readable `/etc/passwd`.

2.  **C. `adduser jdoe sudo`**
    *   Explanation: On Debian/Ubuntu systems, `adduser <user> <group>` is the common command-line utility to add an existing user to an existing group. `usermod -aG sudo jdoe` also works but `adduser` is often preferred for interactive use.

3.  **A. 751**
    *   Explanation: Numeric permissions break down as Owner-roup-Other. 7 (rwx) = 4+2+1. 5 (r-x) = 4+0+1. 1 (--x) = 0+0+1. So, 751 matches Owner=rwx, Group=r-x, Other=--x.

4.  **C. `systemctl list-units --type=service --state=active`**
    *   Explanation: This `systemctl` command specifically filters for unit files of type 'service' that are currently in the 'active' (running) state.

5.  **C. `DENY`**
    *   Explanation: A deny-by-default policy for incoming traffic is a core security principle. You explicitly allow only necessary traffic. `REJECT` sends a response, while `DENY` (or `DROP`) silently discards the packet. `DENY` is generally preferred for external interfaces.

6.  **C. `PermitRootLogin no`**
    *   Explanation: This specific directive within `sshd_config` controls whether the root user is allowed to log in directly via SSH. Setting it to `no` is a standard security practice.

7.  **B. `apt upgrade`**
    *   Explanation: `apt update` refreshes the list of available packages. `apt upgrade` actually downloads and installs the newer versions of packages already installed on the system based on the refreshed list.

8.  **B. Allows anyone to execute the file with the permissions of the file's owner.**
    *   Explanation: The SUID bit allows a user executing the file to temporarily gain the privileges of the file's owner (often root) *while the program is running*. This is used for specific tasks like `passwd` changing the password file, but can be dangerous if set on arbitrary scripts or programs.

9.  **D. `/etc/login.defs`**
    *   Explanation: This file contains system-wide default settings for user account creation and password aging policies like `PASS_MAX_DAYS`, `PASS_MIN_DAYS`, and `PASS_WARN_AGE`.

10. **C. SGID Bit**
    *   Explanation: When the execute bit (`x`) is also present for the group, an `s` in the group permission field indicates the Set Group ID (SGID) bit is set. If set on a directory, new files/dirs created within it inherit the directory's group. If set on an executable, the process runs with the group privileges of the file's group owner.

## Section 2: True/False (1 point each)

11. **True**
    *   Explanation: By convention and system design, the superuser (root) account always has UID 0.

12. **True**
    *   Explanation: `6` (rw-) = 4+2+0. `0` (---) = 0+0+0. So `600` means only the owner has read and write permissions.

13. **False**
    *   Explanation: Disabling the firewall significantly increases the system's exposure to network attacks and is strongly discouraged, especially during a competition.

14. **False**
    *   Explanation: `/etc/passwd` needs to be readable by all users so the system can look up user information (like UID, GID, shell). Correct permissions are typically `644` (rw-r--r--). `/etc/shadow` should be `640` or `600`.

15. **True**
    *   Explanation: `visudo` locks the sudoers file and performs syntax checking before saving, preventing errors that could lock users out of `sudo`.

16. **False**
    *   Explanation: `disabled` means the service won't start automatically on boot, but it can still be started manually using `systemctl start <service_name>`.

17. **True**
    *   Explanation: The sticky bit on a world-writable directory restricts file deletion/renaming so that only the file's owner (or the directory owner/root) can perform those actions.

18. **False**
    *   Explanation: `fail2ban` is an intrusion prevention tool that monitors log files for malicious patterns (like repeated failed logins) and temporarily bans offending IP addresses using firewall rules.

19. **True**
    *   Explanation: SSH keys are much harder to brute-force than passwords and avoid issues with password complexity and reuse.

20. **False**
    *   Explanation: `apt update` only refreshes the package lists from the repositories. `apt upgrade` is needed to actually download and install the updates.

## Section 3: Short Answer (3 points each)

21. **Commands to check logged-in users:** (Any two)
    *   `who`: Shows basic information about logged-in users.
    *   `w`: Shows who is logged in and what they are doing (more detail than `who`).
    *   `last`: Shows history of recent logins (including current ones).
    *   `users`: Lists usernames of currently logged-in users.

22. **Why disable unnecessary services:**
    *   Reduces the system's **attack surface**. Every running service is a potential entry point for attackers if it has vulnerabilities. Fewer services mean fewer potential weaknesses to exploit. It also simplifies system management and monitoring.

23. **Purpose and permissions of `/etc/shadow`:**
    *   Purpose: Stores the **encrypted (hashed) passwords** and password aging information for user accounts.
    *   Why restrictive permissions: It contains sensitive password hashes. If non-root users could read it, they could potentially run **offline brute-force or dictionary attacks** against the hashes to crack passwords. Permissions should be `640` (root readable, shadow group readable) or `600` (root readable/writable only).

24. **Two SSH security settings (besides `PermitRootLogin no`):** (Any two)
    *   `PasswordAuthentication no`: Disables password logins, forcing key-based authentication (more secure).
    *   `Protocol 2`: Ensures only the more secure SSHv2 protocol is used.
    *   `MaxAuthTries 3` (or lower): Limits the number of login attempts per connection, hindering brute-force attacks.
    *   `AllowUsers user1 user2` / `AllowGroups groupname`: Restricts login only to specified users or groups (whitelisting).
    *   `ClientAliveInterval 300` / `ClientAliveCountMax 0`: Helps terminate idle sessions.
    *   `X11Forwarding no`: Disables X11 forwarding if not needed, reducing attack surface.
    *   `PermitEmptyPasswords no`: Prevents login with empty passwords.

25. **`find` command for user's files:**
    *   `find /home -type f -user malicious_user`
    *   Explanation: `find /home` starts searching in the /home directory. `-type f` looks only for files. `-user malicious_user` specifies the owner to match.

## Section 4: Scenario Analysis (5 points each)

26. **Meaning and Action:**
    *   Meaning: The command lists all usernames from `/etc/passwd` that have a User ID (UID) of 0. UID 0 signifies the **root user (superuser)**. Seeing `root` is normal, but seeing `backup_admin` means this account **also has full root privileges**.
    *   Action: This is a major security risk. The `backup_admin` account should be investigated immediately. Unless explicitly authorized and documented (highly unlikely for a non-root account name with UID 0), its password should be changed, the account locked (`passwd -l backup_admin` or `usermod -L backup_admin`), and ideally, its UID changed to a non-zero value or the account removed (`userdel backup_admin`) after verifying its purpose. The priority is to remove its root privileges.

27. **Apache Checks and Restart:**
    *   Check 1: **Review loaded modules.** Use `apache2ctl -M` or check configuration files (`/etc/apache2/mods-enabled/`) to see if unnecessary or potentially dangerous modules (like `mod_status` exposed publicly, `mod_userdir`, `mod_info`) are enabled. Disable unneeded ones using `a2dismod <module_name>`.
    *   Check 2: **Examine Directory permissions/options.** Look in `/etc/apache2/apache2.conf` or site configuration files (`/etc/apache2/sites-enabled/`) for `<Directory>` blocks. Ensure `Options -Indexes` is set to prevent directory listing and check for overly permissive `AllowOverride` settings.
    *   Restart Command: `sudo systemctl restart apache2`

28. **Permission Risk and Fix:**
    *   Risk: Permissions `-rwxrwxrwx` (numeric `777`) mean **anyone** on the system can read, write, and execute the `monitor.sh` script. A regular user could modify the script to contain malicious commands (e.g., delete files, create a reverse shell). If another user (or even root via a cron job) runs this script, the malicious code would execute with their privileges.
    *   Fix Command: `chmod 754 /home/someuser/monitor.sh`
        *   Explanation: `7` (rwx) for the owner, `5` (r-x) for the group, `4` (r--) for others. This allows the owner full control, the group to read/execute, and others only to read. Adjust group/other permissions based on actual need (e.g., `750` if others don't need read access).

---

## Bonus Question (4 points)

29. **`apt update` vs `apt upgrade`:**
    *   `apt update`: **Does not install or upgrade any packages.** It downloads the latest package information (lists of packages, versions, dependencies) from the repositories defined in `/etc/apt/sources.list` and `/etc/apt/sources.list.d/`. It essentially synchronizes the local package index cache with the remote repositories.
    *   `apt upgrade`: **Installs the newer versions** of packages that are already installed on the system, based on the information gathered by `apt update`. It will not remove packages or install new ones that weren't already present (unless they are new dependencies).
    *   Why both: You must run `apt update` first so the system knows *what* newer versions are available. Then, `apt upgrade` uses that updated information to perform the actual installations/upgrades. Running `upgrade` without `update` first means you'll only upgrade based on potentially outdated package lists.

---
