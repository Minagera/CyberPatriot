# Linux Security Fundamentals Quiz (CyberPatriot Intermediate)

## Overview

This quiz assesses your understanding of essential Linux security practices commonly encountered in CyberPatriot. It focuses on user accounts, file system security, running services, and basic system protection on Ubuntu/Linux Mint.

**Time Allowed**: 35 minutes
**Total Points**: 50
**Passing Score**: 40 points (80%)

## Instructions

1.  Read each question carefully.
2.  Record your answers clearly, numbering them according to the questions.
3.  Use your knowledge of Linux security principles and commands.
4.  After completion, compare your answers to the provided solution key or submit them for grading.

---

## Section 1: Multiple Choice (2 points each)

### 1. On a standard Ubuntu system, where is the hashed password for the user 'cadet' primarily stored?

A. `/etc/passwd`
B. `/etc/group`
C. `/etc/shadow`
D. `/home/cadet/.password`

### 2. You need to give user 'jdoe' the ability to run commands as root using `sudo`. Which command is the standard way to add 'jdoe' to the appropriate group on Ubuntu?

A. `groupadd jdoe sudo`
B. `usermod -g sudo jdoe`
C. `adduser jdoe sudo`
D. `chgrp sudo /home/jdoe`

### 3. What numeric permission mode allows the owner to read/write/execute, the group to read/execute, and others to only execute?

A. 751
B. 644
C. 755
D. 741

### 4. Which command provides the most detailed list of currently *active and running* services managed by `systemd`?

A. `ps -ef | grep service`
B. `service --status-all`
C. `systemctl list-units --type=service --state=active`
D. `netstat -tulpn`

### 5. When configuring the UFW firewall, what is the recommended default policy for *incoming* network traffic for security?

A. `ALLOW`
B. `REJECT`
C. `DENY`
D. `FORWARD`

### 6. To prevent direct root login via SSH, which setting should be modified in `/etc/ssh/sshd_config`?

A. `AllowRootLogin no`
B. `PasswordAuthentication no`
C. `PermitRootLogin no`
D. `RootLogin deny`

### 7. Which command is used to apply system security updates listed in the package manager cache on Ubuntu?

A. `apt update`
B. `apt upgrade`
C. `apt install --security-updates`
D. `dpkg --configure -a`

### 8. What does the 'SUID' (Set User ID) permission bit allow when set on an executable file?

A. Allows the file to be executed by members of the file's group.
B. Allows anyone to execute the file with the permissions of the file's owner.
C. Allows the file's owner to execute it with root privileges.
D. Allows the file to inherit the group ID of the directory it's in.

### 9. Which file is commonly used to define system-wide defaults for password aging policies (like `PASS_MAX_DAYS`)?

A. `/etc/passwd`
B. `/etc/pam.d/common-password`
C. `/etc/shadow`
D. `/etc/login.defs`

### 10. You find a file with permissions `-rwxr-sr-x`. What does the 's' in the group permissions indicate?

A. Sticky Bit
B. SUID Bit
C. SGID Bit
D. Special Attribute

## Section 2: True/False (1 point each)

### 11. The `root` user always has a User ID (UID) of 0.

True / False

### 12. The command `chmod 600 sensitive_data.txt` makes the file readable and writable only by the owner.

True / False

### 13. It is generally safe to disable the UFW firewall during a CyberPatriot competition to make troubleshooting easier.

True / False

### 14. The `/etc/passwd` file should ideally have permissions set to `600` (read/write for owner only).

True / False

### 15. Using `visudo` is the recommended way to edit the `/etc/sudoers` file to prevent syntax errors.

True / False

### 16. Services listed as `disabled` in `systemctl list-unit-files` cannot be started manually.

True / False

### 17. Setting the sticky bit (`chmod +t`) on a world-writable directory like `/tmp` helps prevent users from deleting each other's files.

True / False

### 18. `fail2ban` is a tool primarily used for encrypting file systems.

True / False

### 19. Key-based SSH authentication is generally considered more secure than password-based authentication.

True / False

### 20. Running `apt update` installs the latest security patches on the system.

True / False

## Section 3: Short Answer (3 points each)

### 21. List two different commands you could use to check which users are currently logged into the Linux system.

### 22. Briefly explain why removing or disabling unnecessary services is an important security step.

### 23. What is the purpose of the `/etc/shadow` file, and why should its permissions be kept restrictive (e.g., readable only by root)?

### 24. Name two settings you would check or change in `/etc/ssh/sshd_config` to make SSH access more secure (besides disabling root login).

### 25. You need to find all files owned by the user `malicious_user` within the `/home` directory. What `find` command could you use?

## Section 4: Scenario Analysis (5 points each)

### 26. You run `awk -F: '$3 == 0 {print $1}' /etc/passwd` and see the output includes `root` and `backup_admin`. What does this output mean, and what immediate security action should you take regarding `backup_admin`?

### 27. During a competition, the README file states that the web server (Apache) must remain running, but you suspect it's configured insecurely. Describe two specific checks you would perform on the Apache configuration and one command to restart the service after making changes.

### 28. You find a script named `monitor.sh` in `/home/someuser/` with permissions `-rwxrwxrwx`. Explain the security risk associated with these permissions and provide the command to change them to be more secure (readable/writable/executable by owner, readable/executable by group, readable by others).

---

## Bonus Question (4 points)

### 29. Explain the difference between `apt update` and `apt upgrade`. Why is it important to run both commands (usually `update` first) when patching a system?

---

## Additional Information

- PDF Version: [Download PDF Version](../Resources/Linux_Security_Fundamentals_Quiz.pdf) (Placeholder - create if needed)

## For Mentors

The solution key is available in the [Solutions](../Solutions/Linux_Security_Fundamentals_Quiz_Solution.md) directory. Consider using this quiz for:

1.  **Baseline Assessment**: Gauge understanding before starting Linux modules.
2.  **Mid-Module Check**: Reinforce concepts learned.
3.  **Practice**: Simulate competition pressure with the time limit.
4.  **Review**: Identify areas needing further instruction.

---

*Mentor Note: Ensure the solution key is not accessible to cadets before they attempt the quiz.*
