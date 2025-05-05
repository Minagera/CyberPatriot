# Linux Security Training Materials

This directory contains training materials for securing Linux systems (focusing on Ubuntu and Linux Mint distributions) within the CyberPatriot competition context.

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

### [Checklists/](Checklists/README.md)
Links to the detailed Linux checklist in the main `Checklists/Linux/` directory. Covers user accounts, permissions, services, firewall, updates, and forensics.

### [Exercises/](Exercises/README.md)
Hands-on practice scenarios simulating CyberPatriot challenges on Linux, including basic hardening, service configuration, and forensic investigation.

### [Guides/](Guides/README.md)
In-depth guides on Linux security fundamentals and advanced topics relevant to the competition.
-   **[Basic/](Guides/Basic/README.md)**: Core concepts like user management, permissions, basic commands, package management (apt).
-   **[Advanced/](Guides/Advanced/README.md)**: Deeper dives into services (systemd), firewall (UFW), SSH hardening, PAM, logging, and common vulnerabilities.

### [Quizzes/](Quizzes/README.md)
Quizzes testing knowledge of Linux commands, security concepts, configuration files, and hardening techniques.

### [Scripts/](Scripts/README.md)
Unique Bash scripts for automating security checks, audits, and common hardening tasks on Linux systems. Includes examples for user audits, service checks, finding world-writable files, etc.

### [VM-Setup/](VM-Setup/README.md)
Scripts and documentation for creating compromised Linux virtual machine environments (Ubuntu/Mint) for realistic incident response training.

---

## CyberPatriot Competition Tips for Linux

-   **Read the README:** This is always the first and most critical step. Identify required users, services, prohibited actions, and forensic questions.
-   **User Accounts:**
    *   Use `cat /etc/passwd` and `cat /etc/group` to identify users/groups.
    *   Remove unauthorized users (`sudo userdel -r [username]`).
    *   Change weak passwords (`sudo passwd [username]`).
    *   Check for users with UID 0 (`awk -F: '($3 == 0)' /etc/passwd`).
    *   Review sudoers (`sudo cat /etc/sudoers`, `sudo ls /etc/sudoers.d/`) and remove unauthorized users from the `sudo` or `wheel` group (`sudo deluser [username] sudo`).
    *   Disable unused accounts (`sudo passwd -l [username]`).
-   **Password Policy:** Configure PAM (`/etc/pam.d/common-password`) for complexity and `/etc/login.defs` for aging. Install `libpam-pwquality` if needed.
-   **Services (`systemctl`):**
    *   List running services (`systemctl list-units --type=service --state=running`).
    *   List listening ports (`sudo ss -tulpn`).
    *   Disable unnecessary/insecure services (e.g., `telnet`, `vsftpd` if not required, `apache2` if not required) using `sudo systemctl disable --now [service-name]`.
    *   Check service configurations (e.g., `/etc/ssh/sshd_config`, `/etc/apache2/apache2.conf`). Harden SSH (disable root login, use keys, change port if allowed).
-   **Firewall (UFW):**
    *   Ensure UFW is installed (`sudo apt install ufw`).
    *   Enable it (`sudo ufw enable`).
    *   Check status (`sudo ufw status verbose`).
    *   Allow required services/ports (e.g., `sudo ufw allow ssh`, `sudo ufw allow http`) and deny others. Default deny incoming (`sudo ufw default deny incoming`).
-   **Updates:** Run `sudo apt update && sudo apt upgrade -y` if allowed by README and time permits.
-   **Permissions:**
    *   Find world-writable files/directories (`find / -type d -perm -0002 -ls`, `find / -type f -perm -0002 -ls`). Correct permissions (`chmod o-w [file/dir]`).
    *   Find SUID/SGID files (`find / -perm /6000 -type f -ls`). Investigate and remove SUID/SGID bit if unnecessary (`chmod -s [file]`).
-   **Forensics:** Use `find`, `grep`, `cat`, `ls -la` to search for files mentioned in the README, check logs (`/var/log/`), examine cron jobs (`crontab -l`, `/etc/cron.*`), check shell history (`history`, `~/.bash_history`).
-   **Documentation:** Log all changes made.

---

## Reference Files

-   **[../Resources/References/Linux_Security_Reference.md](../Resources/References/Linux_Security_Reference.md)**: Quick reference for user management, permissions, services, firewall, and forensics.
-   **[../Checklists/Linux/README.md](../Checklists/Linux/README.md)**: Competition checklist for Ubuntu/Mint hardening.
-   **[../Resources/Core_Security_Principles.md](../Resources/Core_Security_Principles.md)**: Core security principles for CyberPatriot.

---

*All materials in this directory are unique and tailored for CyberPatriot cadet training. If you find missing content or have suggestions, please contribute!*
