# Linux Security Training Materials (Ubuntu Focus - 25-26 Season)

This directory provides resources for mastering Linux (specifically Ubuntu/Debian-based systems) security within the CyberPatriot competition framework.

## Directory Structure

```
Linux/
├── Guides/                 # Educational guides for Linux security
│   ├── Basic/              # Fundamental Linux security concepts
│   │   ├── README.md
│   │   └── Linux_User_Management.md
│   ├── Intermediate/       # More advanced security configurations
│   │   └── README.md
│   └── Advanced/           # Complex security implementations
│       └── README.md
│
├── Exercises/              # Hands-on Linux security exercises
│   ├── README.md
│   └── Solutions/          # Mentor-only solutions for exercises
│
├── Scripts/                # Bash scripts for Linux hardening
│   ├── Templates/          # Script templates for cadets to modify
│   │   ├── secure_user_add.sh
│   │   ├── audit_services.sh
│   │   ├── find_world_writable.sh
│   │   ├── ufw_hardening.sh
│   │   ├── ssh_hardening.sh
│   │   └── user_management_template.sh
│   ├── Examples/           # Example scripts for reference
│   │   ├── Quick_User_Audit.sh
│   │   ├── Service_Checker.sh
│   │   ├── File_Permission_Scanner.sh
│   │   ├── Firewall_Status_Reporter.sh
│   │   ├── secure_user_add.sh
│   │   ├── audit_services.sh
│   │   ├── find_world_writable.sh
│   │   ├── ufw_hardening.sh
│   │   └── ssh_hardening.sh
│   └── Solutions/          # Solution scripts (mentor access only)
│       ├── linux_challenge_solution.sh
│       └── automated_hardening_solution.sh
│
├── Quizzes/                # Assessment materials
│   ├── README.md
│   ├── Quiz-Files/         # Quiz questions in various formats
│   │   ├── README.md
│   │   └── sample_quiz.md
│   └── Solutions/          # Answer keys for quizzes
│       ├── README.md
│       └── sample_quiz_solutions.md
│
└── VM-Setup/               # Instructions for setting up Linux VMs
    ├── README.md
    ├── corporate-server-breach.sh
    ├── cyberpatriot_linux_vm_setup.sh
    ├── ubuntu_vm_setup.sh
    ├── Linux_Security_Challenge.zip
    └── Linux_Security_Challenge.zip.README.md
```

## Getting Started

1. Begin by setting up a Linux VM using the instructions in the [VM-Setup](./VM-Setup) directory
2. Review the basic security concepts in the [Guides/Basic](./Guides/Basic) directory
3. Try the introductory exercises
4. Explore the script examples to learn about automation

## Learning Path

For optimal learning, we recommend following this sequence:

1. Basic Linux commands and system administration
2. User account security and permissions
3. Service and application security
4. Network security and firewall configuration
5. Logging and monitoring
6. Advanced security hardening techniques

## CyberPatriot Competition Tips

- The Linux portion of CyberPatriot typically involves:
  - Securing user accounts (removing unauthorized users, setting appropriate permissions)
  - Configuring password policies
  - Securing system services
  - Configuring the firewall (UFW/iptables)
  - Removing malware and unauthorized software
  - Addressing specific vulnerabilities mentioned in the competition README

- Focus on completing the highest-value items first
- Always read the competition README file thoroughly
- Use checklists to ensure you don't miss critical steps
- Document your changes in case you need to troubleshoot
- Learn to use the `find` command to locate suspicious files

## Linux Security Fundamentals

The key areas of Linux security covered in these materials include:

1. **User Account Security**
   - User management and authentication
   - Password policies
   - Privilege management
   - Group configuration
   - Sudo access control

2. **File System Security**
   - File permissions
   - Special permissions (SUID, SGID, sticky bit)
   - File attributes
   - Access Control Lists (ACLs)
   - Disk encryption

3. **System Service Security**
   - Service configuration and hardening
   - Disabling unnecessary services
   - Running services with minimal privileges
   - Secure SSH configuration
   - Secure web server configuration

4. **Network Security**
   - Firewall configuration (UFW/iptables)
   - Network service hardening
   - Port management
   - Traffic filtering
   - Intrusion detection

5. **Auditing and Logging**
   - Log configuration
   - Log monitoring
   - Audit frameworks
   - Intrusion detection systems

## Scripting and Automation

The Scripts directory contains Bash scripts for:
- Automating security checks
- Hardening system components
- Auditing security settings
- Performing system inventory

Learning to use these scripts will help you work more efficiently during competitions.

## Additional Resources

- [Ubuntu Security Documentation](https://ubuntu.com/security)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NIST Linux Security Guidelines](https://csrc.nist.gov/publications/detail/sp/800-123/final)
- [CyberPatriot Linux Training Materials](https://www.uscyberpatriot.org/competition/training-materials/linux)

---

## Directory Index

-   [**Guides/**](Guides/README.md)
    *   Contains `Basic/` and `Advanced/` guides covering fundamental CLI usage, user/group management, permissions, services (`systemctl`), networking (`ip`, `ss`), firewalls (UFW), and progressing to advanced topics like PAM, logging (`journalctl`), SSH hardening, and basic forensics. **Uniquely focused on CP tasks.**
-   [**Checklists/**](../Checklists/Linux/README.md)
    *   **Link to the main Linux checklist.** Offers a structured workflow for hardening Ubuntu systems rapidly during competition, always prioritizing the README.
-   [**Exercises/**](../Exercises/Linux/README.md) (Create if missing)
    *   Practical labs and scenarios for practicing Linux hardening, vulnerability remediation, persistence hunting, and forensic analysis on Ubuntu systems.
-   [**Scripts/**](Scripts/README.md)
    *   Unique Bash scripts designed for security auditing and reconnaissance on Linux systems (checking users, sudoers, services, listening ports, common persistence points). **Emphasizes safe information gathering.**
-   [**VM-Setup/**](VM-Setup/README.md)
    *   Essential resources (`corporate-server-breach.sh`) for creating compromised Ubuntu VM environments that simulate realistic CyberPatriot incident response challenges.

---

## CyberPatriot Competition Tips for Linux (Unique Focus)

-   **README is KING:** The absolute first step. Identify required users/services, prohibited actions, scoring tasks, and forensic clues. Document constraints immediately.
-   **User Account Security:** Master user/group management (`useradd`, `usermod`, `userdel`, `groupadd`, `passwd`). Identify users via `/etc/passwd`, `/etc/group`, `/etc/shadow`. Remove unauthorized users (`sudo userdel -r [user]`). Change ALL passwords to strong, unique ones (`sudo passwd [user]`). Check for UID 0 users (`awk -F: '($3 == 0)' /etc/passwd`). Scrutinize `/etc/sudoers` and `/etc/sudoers.d/` (`visudo` is safe editor), remove unauthorized sudo access (`sudo deluser [user] sudo`). Disable unused accounts (`sudo passwd -l [user]`).
-   **Password Policy (PAM & login.defs):** Configure password complexity via PAM (`/etc/pam.d/common-password`, requires `libpam-pwquality`). Set password aging policies (`PASS_MAX_DAYS`, `PASS_MIN_DAYS`, `PASS_WARN_AGE`) in `/etc/login.defs`. Apply aging to existing users (`sudo chage -M 90 -m 7 -W 14 [user]`).
-   **Service Management (`systemctl` & `ss`):** List running/enabled services (`systemctl list-units --type=service --state=running`, `systemctl list-unit-files --state=enabled`). Identify listening ports/services (`sudo ss -tulpn`). Disable unnecessary/insecure services (e.g., `telnet`, `vsftpd` if not needed, web servers if not required) using `sudo systemctl disable --now [service]`. **Verify against README requirements before disabling.** Harden critical service configs (e.g., `/etc/ssh/sshd_config` - `PermitRootLogin no`, `PasswordAuthentication no` (if keys used), `Protocol 2`).
-   **Firewall (UFW):** Ensure UFW is installed (`sudo apt install ufw -y`). Enable it (`sudo ufw enable`). Set default deny for incoming traffic (`sudo ufw default deny incoming`). Allow only necessary services/ports based *explicitly* on the README (`sudo ufw allow ssh`, `sudo ufw allow http`, `sudo ufw allow 8080/tcp`). Check status (`sudo ufw status verbose`).
-   **Updates:** Run `sudo apt update && sudo apt upgrade -y` **only if** the README allows and time permits. Be aware upgrades can sometimes break scoring.
-   **Permissions & SUID/SGID:** Find world-writable files/dirs (`find / -type d -perm -002 -ls`, `find / -type f -perm -002 -ls`) and fix (`chmod o-w [target]`). Find SUID/SGID files (`find / -perm /6000 -type f -ls`), investigate suspicious ones (non-standard binaries), and remove the bit if unauthorized (`chmod -s [file]`). Check critical file permissions (`/etc/passwd`, `/etc/shadow`, `/etc/sudoers`).
-   **Persistence Hunting:** Look for cron jobs (user: `crontab -l -u [user]`, system: `/etc/crontab`, `/etc/cron.*`). Check `systemd` services/timers (`/etc/systemd/system/`). Examine shell startup files (`.bashrc`, `.profile`). Look for suspicious SUID binaries. Check for modified binaries (use `dpkg --verify` if time permits).
-   **Forensic Investigation:** Search common locations (`/home/*/Desktop`, `/home/*/Documents`, `/tmp`, `/var/tmp`, `/root`) and user directories for READMEs, answer files, or clues. Use `grep -r` to search file contents. Analyze logs in `/var/log` (`syslog`, `auth.log`, `ufw.log`) and `journalctl` for relevant events (logins, sudo usage, service starts/stops, UFW blocks). Check command history (`history`, `.bash_history`).
-   **Documentation & Verification:** Keep a Change Log. Check scoring frequently. Use documentation to revert changes if needed.
-   **Baselining:** Use commands (`getent passwd`, `systemctl list-units --state=running`, `ss -tulpn`, `crontab -l`, `find / -perm /6000`) at the start. Compare output later or use Meld.

---

## Reference Files

-   **[../Resources/References/Linux_Security_Reference.md](../Resources/References/Linux_Security_Reference.md)**: Quick reference for user management, permissions, services, firewall, and forensics.
-   **[../Checklists/Linux/README.md](../Checklists/Linux/README.md)**: Competition checklist for Ubuntu/Mint hardening.
-   **[../Resources/Core_Security_Principles.md](../Resources/Core_Security_Principles.md)**: Core security principles for CyberPatriot.

---

*All materials in this directory are unique and tailored for CyberPatriot cadet training aiming for National-level performance. Use the README files within each subdirectory for more specific guidance.*
