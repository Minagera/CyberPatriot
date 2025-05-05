# Linux Security Training Materials

This directory provides unique training materials specifically focused on securing Linux environments (Ubuntu, Linux Mint) within the context of the CyberPatriot competition, emphasizing an incident response and remediation approach suitable for Nationals.

**Always start by reading the README file in each subdirectory.**

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Contains unique guides covering Basic, Intermediate, and Advanced Linux security concepts, command-line tools, user/permission management, service hardening (systemd), firewall configuration (UFW/iptables), scripting (Bash), logging, and forensic techniques relevant to CyberPatriot.
-   [**Exercises/**](Exercises/README.md)
    *   Hands-on practice scenarios specifically designed for Linux, ranging from basic CLI tasks to complex incident response simulations involving common Linux vulnerabilities.
-   [**Scripts/**](Scripts/README.md)
    *   Unique Bash scripts developed for auditing, information gathering, and potentially safe automation tasks common in CyberPatriot Linux images. Includes templates, examples, and potentially solutions.
-   [**Quizzes/**](Quizzes/README.md)
    *   Linux-specific quizzes (`Quiz-Files/`) and corresponding answer keys (`Solutions/`) for assessing cadet knowledge on Linux security topics.
-   [**VM-Setup/**](../VM-Setup/Linux/README.md) (Link to main VM-Setup section for Linux)
    *   Provides scripts (`corporate-server-breach.sh`) and documentation for creating compromised Linux virtual machine environments for incident response training.

---

## Training Focus (Nationals Level)

-   **Incident Response:** Identifying unauthorized users (including UID 0), groups, processes, services (`systemd`), cron jobs (user/system), SUID/SGID files, modified startup files (`.bashrc`, etc.), and other persistence mechanisms.
-   **System Hardening:** Managing users/groups (`useradd`, `usermod`, `userdel`, `groupadd`, etc.), configuring `sudoers`, setting password policies (PAM, `login.defs`), securing services (especially SSH - `sshd_config`), configuring UFW firewall rules, managing package updates (`apt`), securing file permissions (including `chmod`, `chown`, ACLs).
-   **Forensic Analysis:** Using core utilities (`grep`, `find`, `awk`, `sed`), analyzing logs (`journalctl`, `/var/log/`), examining command history, understanding process/network activity (`ps`, `ss`, `netstat`), checking file integrity concepts.
-   **Tool Proficiency:** Mastering essential command-line tools (`ls`, `cd`, `cat`, `less`, `nano`/`vim`, `systemctl`, `ufw`, `passwd`, `sudo`, `find`, `grep`, `ps`, `ss`, `ip`, `history`, `journalctl`, `crontab`, `chmod`, `chown`, `getfacl`, `setfacl`).

## CyberPatriot Competition Tips for Linux

-   **Read the README:** This is always the first and most critical step. Identify required users, services, prohibited actions, and forensic questions. *It overrides general best practices.*
-   **User Accounts:**
    *   Use `cat /etc/passwd` and `cat /etc/group` to identify users/groups. Check `/etc/shadow` for password status.
    *   Remove unauthorized users (`sudo userdel -r [username]`).
    *   Change weak passwords (`sudo passwd [username]`).
    *   Check for users with UID 0 (`awk -F: '($3 == 0)' /etc/passwd`). Investigate any non-root UID 0 users.
    *   Review sudoers (`sudo cat /etc/sudoers`, `sudo visudo`, `sudo ls /etc/sudoers.d/`) and remove unauthorized users/groups from sudo access (`sudo deluser [username] sudo`).
    *   Disable unused accounts (`sudo passwd -l [username]` or `sudo usermod -L [username]`).
-   **Password Policy:** Configure PAM (`/etc/pam.d/common-password`) for complexity (install `libpam-pwquality` if needed) and `/etc/login.defs` for aging requirements (e.g., `PASS_MAX_DAYS`, `PASS_MIN_DAYS`).
-   **Services (`systemctl`):**
    *   List running services (`systemctl list-units --type=service --state=running`).
    *   List listening ports (`sudo ss -tulpn`).
    *   Disable unnecessary/insecure services (e.g., `telnet`, `vsftpd` if not required, `apache2`/`nginx` if not required) using `sudo systemctl disable --now [service-name]`.
    *   Check service configurations (e.g., `/etc/ssh/sshd_config`, `/etc/apache2/apache2.conf`). Harden SSH (disable root login - `PermitRootLogin no`, use keys if possible, consider changing port if allowed by README).
-   **Firewall (UFW):**
    *   Ensure UFW is installed (`sudo apt install ufw`).
    *   Enable it (`sudo ufw enable`). **Crucially, allow required services BEFORE enabling** (e.g., `sudo ufw allow ssh`, `sudo ufw allow http`).
    *   Check status (`sudo ufw status verbose`).
    *   Set default deny for incoming traffic (`sudo ufw default deny incoming`).
    *   Set default allow for outgoing traffic (`sudo ufw default allow outgoing`).
-   **Updates:** Run `sudo apt update && sudo apt upgrade -y` if allowed by README and time permits.
-   **Permissions:**
    *   Find world-writable files/directories (`find / -type d -perm -0002 -ls`, `find / -type f -perm -0002 -ls`). Correct permissions (`chmod o-w [file/dir]`). Be careful not to break system functionality (avoid changing `/tmp` or `/var/tmp` without understanding implications).
    *   Find SUID/SGID files (`find / -perm /6000 -type f -ls`). Investigate unusual entries and remove SUID/SGID bit if unnecessary (`sudo chmod -s [file]`).
-   **Persistence:** Hunt for malware persistence: Cron jobs (`crontab -l -u [user]`, `ls /etc/cron.*`), systemd timers/services (`systemctl list-timers`, check `/etc/systemd/system/`), SUID binaries, modified shell startup files (`.bashrc`, `.profile`), malicious kernel modules (`lsmod`).
-   **Forensics:** Search common locations (Desktop, Documents, `/tmp`, `/var/tmp`, web server roots) for READMEs, answer files, or clues. Use `find`, `grep`, and check logs (`journalctl`, `auth.log`, `syslog`).
-   **Documentation:** Log all changes using templates from `../Resources/Templates/`.

## Reference Files

-   **[../Resources/References/Linux_Security_Reference.md](../Resources/References/Linux_Security_Reference.md)**: Quick reference for user management, permissions, services, firewall, and forensics.
-   **[../Checklists/Linux/README.md](../Checklists/Linux/README.md)**: Competition checklist for Ubuntu/Mint hardening (use *after* reading the competition README).
-   **[../Resources/Core_Security_Principles.md](../Resources/Core_Security_Principles.md)**: Core security principles for CyberPatriot.

---

*All materials in this directory are unique and tailored for CyberPatriot cadet training. If you find missing content or have suggestions, please contribute!*
