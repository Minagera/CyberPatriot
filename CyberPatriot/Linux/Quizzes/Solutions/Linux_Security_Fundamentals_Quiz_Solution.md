# Linux Security Fundamentals Quiz - SOLUTION KEY

## MENTOR ACCESS ONLY - Do Not Share With Cadets

## Multiple Choice Questions (2 points each)

### 1. Which file contains encrypted user passwords on Ubuntu/Linux Mint?

**Answer: B. /etc/shadow**

Explanation: In modern Linux systems, the encrypted password hashes are stored in /etc/shadow, which is only readable by root. The /etc/passwd file contains user information but not the actual password hashes.

### 2. What command is used to change a user's password in Linux?

**Answer: B. passwd**

Explanation: The `passwd` command is used to change user passwords. It can be used by a user to change their own password or by root to change any user's password.

### 3. Which of the following commands adds a user to the sudo group?

**Answer: C. usermod -aG sudo username**

Explanation: The `usermod` command with the `-aG` option adds a user to a supplementary group without removing them from other groups. The `-a` option means "append" and must be used with `-G`.

### 4. What is the correct permission notation (numeric) that gives read, write, and execute permissions to the owner, read and execute to the group, and no permissions to others?

**Answer: B. 750**

Explanation: In numeric notation, 7 represents read (4) + write (2) + execute (1) for the owner, 5 represents read (4) + execute (1) for the group, and 0 represents no permissions for others.

### 5. Which command displays currently running services on a systemd-based Linux system?

**Answer: C. systemctl list-units --type=service**

Explanation: The `systemctl list-units --type=service` command shows all active systemd services. Both Ubuntu and Linux Mint use systemd as their init system.

### 6. What is the default UFW policy that should be set for incoming connections in a secure configuration?

**Answer: C. deny**

Explanation: In a secure configuration, the default UFW policy for incoming connections should be set to deny, which blocks all incoming connections unless explicitly allowed. This is set with `sudo ufw default deny incoming`.

### 7. Which configuration file is used to secure the SSH server on Ubuntu/Linux Mint?

**Answer: B. /etc/ssh/sshd_config**

Explanation: The SSH server configuration is stored in `/etc/ssh/sshd_config`. This file contains all the settings that control SSH server behavior including security options.

### 8. Which command is used to check if the firewall is active in Ubuntu/Linux Mint?

**Answer: C. ufw status**

Explanation: The `ufw status` command shows whether UFW (Uncomplicated Firewall) is active and what rules are configured. UFW is the default firewall configuration tool in Ubuntu and Linux Mint.

### 9. Which special permission, when set on a directory, ensures that only the file's owner can delete or rename files within that directory regardless of the directory's other permissions?

**Answer: C. Sticky bit**

Explanation: The sticky bit (`chmod +t` or mode 1000) prevents users from deleting or renaming files they don't own in directories that are writable by multiple users. It's commonly used on directories like /tmp.

### 10. Which Linux file defines how often users must change their passwords?

**Answer: C. /etc/login.defs**

Explanation: The `/etc/login.defs` file contains settings that control password aging, including PASS_MAX_DAYS (maximum password age), PASS_MIN_DAYS (minimum days between changes), and PASS_WARN_AGE (warning days before expiration).

### 11. Which tool is commonly used to detect rootkits on Linux systems?

**Answer: B. chkrootkit**

Explanation: `chkrootkit` is a widely used tool for scanning Linux systems for signs of rootkits and other malware. It checks for signs of known rootkits, suspicious processes, and modified system files.

### 12. What command shows all user accounts on the system?

**Answer: A. cat /etc/passwd**

Explanation: The `/etc/passwd` file contains the list of all system user accounts. While B (`getent passwd`) is also technically correct, option A is the most direct method to view all local user accounts.

### 13. Which is the most secure method for remote administration of Linux systems?

**Answer: C. SSH with key-based authentication**

Explanation: SSH with key-based authentication is generally considered the most secure option for remote administration because it doesn't rely on passwords that can be brute-forced. It requires possession of the private key, which should be protected by a passphrase.

### 14. What is the correct command to find all SUID files on a system?

**Answer: A. find / -perm /4000**

Explanation: The `find / -perm /4000` command searches the entire filesystem for files with the SUID bit set. The `/4000` notation means "any file that has the SUID bit (4000) set."

### 15. Which of these is NOT a common Linux security tool?

**Answer: D. WindowsDefender**

Explanation: WindowsDefender is Microsoft's security solution for Windows systems, not Linux. SELinux, AppArmor, and Fail2ban are all legitimate Linux security tools.

## True/False Questions (1 point each)

### 16. In Linux, the root user has the UID (User ID) of 0.

**Answer: True**

Explanation: The root user in Linux always has UID 0. This is how the system identifies the root user and grants it full administrative privileges.

### 17. A SUID permission allows the user who executes a file to do so with the permissions of that file's group owner.

**Answer: False**

Explanation: SUID (Set User ID) permission allows a user to execute a file with the permissions of the file's owner, not the group owner. SGID (Set Group ID) allows execution with the permissions of the file's group.

### 18. Files created in a directory with the SGID bit set will inherit the group ownership of that directory.

**Answer: True**

Explanation: When the SGID bit is set on a directory, any files created within that directory will inherit the group ownership of the directory, not the primary group of the user creating the file.

### 19. The command "chmod 777 file.txt" is considered secure because it ensures all users can access the file.

**Answer: False**

Explanation: The permission 777 (rwxrwxrwx) gives full read, write, and execute permissions to everyone, which is highly insecure. It allows any user to modify or execute the file, creating significant security risks.

### 20. In Linux, a normal user can listen on ports below 1024 without special privileges.

**Answer: False**

Explanation: On Linux systems, ports below 1024 are considered privileged ports. Only root (or processes with the CAP_NET_BIND_SERVICE capability) can bind to these ports.

### 21. The /etc/passwd file on modern Linux systems contains encrypted password hashes.

**Answer: False**

Explanation: In modern Linux systems, the /etc/passwd file contains an 'x' in the password field, indicating that the encrypted password is stored in /etc/shadow. This separation improves security as the shadow file is only readable by root.

### 22. When using SSH key-based authentication, it's best practice to protect the private key with a passphrase.

**Answer: True**

Explanation: Adding a passphrase to an SSH private key provides an additional layer of security. If the private key file is compromised, the attacker would still need the passphrase to use it.

### 23. AppArmor and SELinux are both implementations of Mandatory Access Control (MAC).

**Answer: True**

Explanation: Both AppArmor and SELinux implement Mandatory Access Control (MAC) systems, which restrict how processes can access resources based on security policies defined by administrators, rather than traditional discretionary access controls.

### 24. Setting "PermitRootLogin yes" in the SSH configuration file is a recommended security practice.

**Answer: False**

Explanation: Allowing direct root login via SSH is a security risk. Best practice is to set "PermitRootLogin no" and require users to log in with regular accounts and use sudo for privileged operations.

### 25. Running services with the minimum required privileges is a core principle of Linux security.

**Answer: True**

Explanation: The principle of least privilege is a fundamental security concept that states that a process or user should only have the minimum privileges necessary to perform its function, limiting the potential damage from exploitation.

## Short Answer Questions (3 points each)

### 26. List three ways to check for unauthorized users on a Linux system.

**Sample Answer:**
1. Examine the `/etc/passwd` file to list all user accounts
2. Check members of privileged groups: `getent group sudo` or `getent group wheel`
3. Review login history with commands like `last` and `lastlog` to spot unusual accounts
4. Look for accounts with UID 0 (root privileges): `awk -F: '$3 == 0 {print $1}' /etc/passwd`
5. Check for accounts with valid login shells: `grep -v '/nologin\|/false' /etc/passwd`

**Grading Notes:** Award 1 point for each valid method listed. The answer should demonstrate understanding of where user information is stored and how to access it.

### 27. Explain the principle of least privilege and why it's important for Linux security.

**Sample Answer:**
The principle of least privilege states that users, processes, and systems should only have the minimum privileges necessary to perform their functions. In Linux, this means:

- Users should only be granted access to the specific resources they need
- Services should run with the minimum permissions required
- Sudo access should be limited to only necessary commands
- Root access should be used sparingly and only when required

This principle is important because it limits the damage that can occur if a user account or service is compromised. If a service running as a limited user is exploited, the attacker gains only limited privileges, not full system access. This contains security breaches and prevents privilege escalation.

**Grading Notes:** Award 1 point for correctly defining the principle, 1 point for explaining how it applies to Linux, and 1 point for explaining why it's important for security.

### 28. What is the purpose of the "umask" and how does it affect file creation permissions?

**Sample Answer:**
Umask (user mask) is a value that determines the default permissions for newly created files and directories. It works by masking out (removing) specific permission bits from the maximum default permissions, which are 666 (rw-rw-rw-) for files and 777 (rwxrwxrwx) for directories.

When a file or directory is created, the system:
1. Starts with the maximum default permissions
2. Removes (masks) the permission bits specified in the umask value
3. Assigns the resulting permissions to the new file/directory

For example, a umask of 022 removes write permissions for group and others, resulting in 644 (rw-r--r--) for files and 755 (rwxr-xr-x) for directories.

Common umask values:
- 022: rw-r--r-- for files, rwxr-xr-x for directories (typical for most systems)
- 027: rw-r----- for files, rwxr-x--- for directories (more restrictive)
- 077: rw------- for files, rwx------ for directories (highly restrictive)

A secure umask ensures that newly created files don't inadvertently receive excessive permissions.

**Grading Notes:** Award 1 point for explaining what umask is, 1 point for correctly describing how it works, and 1 point for demonstrating understanding of practical umask values.

### 29. Describe three methods to secure SSH on a Linux server.

**Sample Answer:**
1. **Disable root login**: Add `PermitRootLogin no` to sshd_config to prevent direct root login, forcing users to log in as regular users and use sudo for privileged operations.

2. **Implement key-based authentication**: Configure SSH to use public key authentication instead of passwords by setting `PasswordAuthentication no` and adding authorized keys to `~/.ssh/authorized_keys`. This prevents brute force attacks and is more secure than passwords.

3. **Restrict access by IP address**: Use firewall rules (iptables or ufw) to allow SSH connections only from trusted IP addresses, or use the `AllowUsers` and `AllowGroups` directives in sshd_config to specify which users can access the system.

Other valid methods include:
- Changing the default port (22) to a non-standard port
- Using fail2ban to block repeated failed login attempts
- Limiting SSH protocol version to SSHv2 only
- Configuring strong ciphers and MACs
- Setting up two-factor authentication
- Limiting connection attempts with `MaxAuthTries` and `MaxStartups`

**Grading Notes:** Award 1 point for each valid method, with a focus on correctness and practicality. Each method should include both what to do and why it improves security.

### 30. List three locations where an attacker might place a persistence mechanism (backdoor) on a Linux system.

**Sample Answer:**
1. **Startup scripts/services**: Creating malicious systemd service files in `/etc/systemd/system/` or init scripts in `/etc/init.d/` that run at boot time

2. **Cron jobs**: Adding scheduled tasks in `/etc/cron.d/`, `/etc/crontab`, or user crontabs to periodically run malicious code

3. **User profiles/bashrc**: Adding malicious code to shell profile files like `~/.bashrc`, `~/.bash_profile`, or `/etc/profile` that execute when users log in

Other valid locations include:
- SSH authorized_keys files for unauthorized access
- Kernel modules and rootkits in the system
- PAM configuration modifications
- SUID/SGID binaries or modified system executables
- Web server configuration files
- Hidden files in user home directories
- Unexpected user accounts with high privileges
- Scheduled system tasks like anacron or at jobs

**Grading Notes:** Award 1 point for each valid location. The answer should demonstrate understanding of Linux startup processes and persistence techniques.

## Scenario Questions (5 points each)

### 31. You're securing a Linux system and need to check who has sudo access. What commands would you use, and what files would you examine to get this information? Explain how you would interpret the results.

**Sample Answer:**
To check who has sudo access on a Linux system, I would use these commands and examine these files:

1. **Check sudo group membership**:
   ```bash
   getent group sudo
   # or
   grep -Po '^sudo:.*:\K.*$' /etc/group
   ```
   This shows all users in the sudo group, who typically have full sudo privileges.

2. **Examine the sudoers file**:
   ```bash
   sudo cat /etc/sudoers
   # or safely with
   sudo visudo -c
   ```
   The sudoers file contains rules defining who can use sudo and what commands they can run. I would look for lines like:
   - `username ALL=(ALL:ALL) ALL` - User has full sudo access
   - `%groupname ALL=(ALL:ALL) ALL` - Group has full sudo access
   - `username ALL=(ALL:ALL) NOPASSWD: ALL` - User has passwordless sudo (security risk)
   - Command-specific permissions like `username ALL=(ALL:ALL) /bin/ls, /usr/bin/apt`

3. **Check sudoers.d directory**:
   ```bash
   sudo ls -la /etc/sudoers.d/
   sudo cat /etc/sudoers.d/*
   ```
   This directory contains additional sudoers configurations that may grant sudo privileges.

4. **Look for other administrator groups**:
   ```bash
   getent group admin
   getent group wheel  # on some systems
   ```
   Some systems use other groups for administrative access.

To interpret the results, I would:
- Identify all users with full sudo access and verify they should have it
- Check for passwordless sudo access (NOPASSWD), which is generally a security concern
- Look for command-specific restrictions and verify they're appropriate
- Cross-reference the list of sudo users against authorized system administrators
- Document any unauthorized sudo access for removal

**Grading Notes:** Award up to 5 points based on completeness and accuracy. Look for:
- Commands to check sudo group membership (1 point)
- Examination of sudoers file and directory (1 point)
- Proper interpretation of sudoers syntax (1 point)
- Looking for additional sources of privilege (1 point)
- Logical interpretation of results (1 point)

### 32. During a CyberPatriot competition, you discover several unfamiliar services running on your Ubuntu system. Describe the steps you would take to:
   a) Identify these services
   b) Determine if they are legitimate
   c) Secure or remove them if necessary
   Include specific commands you would use at each step.

**Sample Answer:**

**a) Identify the services:**
1. List all running services:
   ```bash
   systemctl list-units --type=service --state=active
   # or
   service --status-all
   ```

2. Get detailed information about unfamiliar services:
   ```bash
   systemctl status service_name
   ```

3. Find out what executable the service is running:
   ```bash
   which service_name
   ls -la /usr/sbin/service_name
   ```

4. Check service configuration:
   ```bash
   cat /lib/systemd/system/service_name.service
   cat /etc/systemd/system/service_name.service
   ```

5. Check open network ports associated with services:
   ```bash
   ss -tulpn | grep service_name
   ```

**b) Determine if the services are legitimate:**
1. Check if the service is mentioned in the competition README file as required
   
2. Research the service online:
   ```bash
   apt show package_name
   ```

3. Check when the service was installed:
   ```bash
   dpkg -l | grep service_name
   ls -la /lib/systemd/system/service_name.service
   ```

4. Check process details and loaded files:
   ```bash
   ps aux | grep service_name
   lsof -p process_id
   ```

5. Check service binary integrity:
   ```bash
   dpkg -V package_name
   ```

6. Look for suspicious behaviors:
   - Services with obfuscated names
   - Recently installed services not part of standard packages
   - Services running from unusual locations (/tmp, /home)
   - Services connecting to external IP addresses
   - Services running under suspicious user accounts

**c) Secure or remove the services if necessary:**
1. For unnecessary services, disable and stop them:
   ```bash
   sudo systemctl stop service_name
   sudo systemctl disable service_name
   ```

2. For required services that need securing:
   - Modify the service configuration:
     ```bash
     sudo systemctl edit service_name
     ```
   - Restrict service permissions:
     ```bash
     sudo nano /lib/systemd/system/service_name.service
     # Add directives like:
     # PrivateTemp=true
     # ProtectSystem=strict
     # ReadOnlyDirectories=/etc /home
     ```
   - Apply least privilege principles (run as non-root user)
   
3. For potentially malicious services, remove completely:
   ```bash
   sudo systemctl stop service_name
   sudo systemctl disable service_name
   sudo apt purge package_name  # If installed via a package
   sudo rm /etc/systemd/system/service_name.service  # If manually installed
   sudo systemctl daemon-reload
   ```

4. Document all changes made for scoring report

**Grading Notes:** Award up to 5 points based on the following:
- Proper service identification methodology (1 point)
- Thorough legitimacy assessment approach (2 points)
- Appropriate remediation steps (1 point)
- Proper command usage and accurate syntax (1 point)

### 33. You've been assigned to secure an Ubuntu web server. List five specific security measures you would implement, explaining why each is important and how you would implement it.

**Sample Answer:**

1. **Implement a Firewall**
   - **Why it's important**: Restricts network access to only necessary services, reducing attack surface and preventing unauthorized access attempts.
   - **Implementation**:
     ```bash
     sudo apt install ufw
     sudo ufw default deny incoming
     sudo ufw default allow outgoing
     sudo ufw allow ssh
     sudo ufw allow http
     sudo ufw allow https
     sudo ufw enable
     ```
   - Regular auditing of firewall rules to ensure they remain appropriate.

2. **Secure SSH Access**
   - **Why it's important**: SSH is a primary administrative entry point and a common target for brute force attacks.
   - **Implementation**:
     ```bash
     sudo nano /etc/ssh/sshd_config
     # Add or modify:
     PermitRootLogin no
     PasswordAuthentication no
     Protocol 2
     AllowUsers admin webadmin
     ```
   - Set up key-based authentication:
     ```bash
     # On client:
     ssh-keygen -t ed25519 -a 100
     ssh-copy-id user@server
     ```
   - Install and configure fail2ban to block repeated failed login attempts.

3. **Harden Web Server Configuration (Apache/Nginx)**
   - **Why it's important**: Prevents common web application attacks and information disclosure.
   - **Implementation** (for Apache):
     ```bash
     sudo nano /etc/apache2/conf-available/security.conf
     # Add or modify:
     ServerTokens Prod
     ServerSignature Off
     TraceEnable Off
     Header always set X-XSS-Protection "1; mode=block"
     Header always set X-Content-Type-Options "nosniff"
     Header always set X-Frame-Options "SAMEORIGIN"
     Header always set Content-Security-Policy "default-src 'self';"
     ```
   - Enable HTTP Strict Transport Security (HSTS):
     ```bash
     Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"
     ```
   - Enable SSL/TLS with strong ciphers:
     ```bash
     sudo a2enmod ssl
     # Configure SSL certificates and ciphers
     ```

4. **Set Up Automated Security Updates**
   - **Why it's important**: Ensures that security patches are applied promptly without manual intervention.
   - **Implementation**:
     ```bash
     sudo apt install unattended-upgrades
     sudo dpkg-reconfigure -plow unattended-upgrades
     sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
     # Ensure security updates are enabled:
     Unattended-Upgrade::Allowed-Origins {
         "${distro_id}:${distro_codename}-security";
     };
     ```
   - Configure automated restart for kernel updates if needed.

5. **Implement File Integrity Monitoring**
   - **Why it's important**: Detects unauthorized file changes that could indicate a compromise.
   - **Implementation**:
     ```bash
     sudo apt install aide
     sudo nano /etc/aide/aide.conf
     # Configure directories to monitor
     # Include web directories and configuration files:
     /var/www/html NORMAL
     /etc/apache2 NORMAL
     ```
   - Initialize AIDE database:
     ```bash
     sudo aideinit
     sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
     ```
   - Set up daily checks:
     ```bash
     sudo nano /etc/cron.daily/aide-check
     # Add:
     #!/bin/sh
     /usr/bin/aide --check | mail -s "AIDE Check Report for $(hostname)" root
     ```

Additional valid measures:
- Implement ModSecurity web application firewall
- Set up AppArmor or SELinux profiles
- Configure proper file permissions for web content
- Set up log monitoring and alerting
- Implement backup strategy
- Use SELinux or AppArmor to confine the web server process
- Implement account lockout policies
- Set up intrusion detection (OSSEC, Wazuh)
- Implement database security measures

**Grading Notes:** Award 1 point for each well-described security measure. Each measure should include why it's important and specific implementation steps with correct command syntax or configuration examples.

## Bonus Question (5 points)

### 34. Explain how an attacker might leverage weak file permissions on key system directories or files to escalate privileges on a Linux system. Give at least two examples of specific files or directories where improper permissions could lead to privilege escalation, and how you would secure them.

**Sample Answer:**

Attackers can leverage weak file permissions on critical system files or directories to escalate privileges from a standard user to root. This typically happens when sensitive files are made writable by non-privileged users, allowing modification of system behavior.

**Example 1: Writable /etc/passwd file**
If the /etc/passwd file has weak permissions (e.g., chmod 666 /etc/passwd), any user could modify it to create a new user with UID 0 (root privileges). The attack would work like this:

1. Generate a password hash:
   ```bash
   openssl passwd -1 -salt xyz password123
   ```
   This generates something like `$1$xyz$fYHFJksLjGFhkasGJkl5M1`

2. Add a new root-privileged user by appending to /etc/passwd:
   ```bash
   echo "hacker:$1$xyz$fYHFJksLjGFhkasGJkl5M1:0:0:Hacked:/root:/bin/bash" >> /etc/passwd
   ```

3. Now the attacker can switch to this user and have full root privileges:
   ```bash
   su hacker
   ```

To secure /etc/passwd, the proper permissions should be 644 (rw-r--r--) and owned by root:
```bash
sudo chmod 644 /etc/passwd
sudo chown root:root /etc/passwd
```

**Example 2: Writable SUID programs**
SUID (Set User ID) executables run with the permissions of the file owner rather than the user executing them. If a SUID program owned by root has weak permissions, an attacker can modify it to execute arbitrary commands with root privileges.

For example, if `/usr/bin/sudo` had weak permissions:
1. The attacker could replace it with a malicious script:
   ```bash
   echo '#!/bin/bash
   echo "Password:" 
   read -s password
   echo "Running command..."
   /bin/bash' > /usr/bin/sudo
   ```

2. When other users run sudo, they'd get a shell with root privileges, and the attacker would also capture their passwords.

To properly secure SUID binaries:
```bash
sudo chmod 4755 /usr/bin/sudo
sudo chown root:root /usr/bin/sudo
```

**Example 3: Writable systemd service files**
If an attacker can modify service files in `/etc/systemd/system/` or `/lib/systemd/system/`, they could replace legitimate service definitions with malicious ones that execute commands as root when the service starts.

For instance, with writable systemd directories:
1. The attacker could modify a service file:
   ```bash
   echo '[Service]
   ExecStart=/bin/sh -c "id > /tmp/pwned && cp /bin/bash /tmp/rootshell && chmod 4777 /tmp/rootshell"
   [Install]
   WantedBy=multi-user.target' > /etc/systemd/system/important-service.service
   ```

2. When the service restarts or the system reboots, the malicious commands execute as root.

To secure systemd service directories:
```bash
sudo chmod 755 /etc/systemd/system
sudo chmod 755 /lib/systemd/system
sudo chmod 644 /etc/systemd/system/*.service
sudo chmod 644 /lib/systemd/system/*.service
sudo chown -R root:root /etc/systemd/system
sudo chown -R root:root /lib/systemd/system
```

**Example 4: Writable cron job files**
If directories like `/etc/cron.d` or files like `/etc/crontab` are writable by non-privileged users, attackers can add entries that execute commands as root on a schedule.

To secure cron directories and files:
```bash
sudo chmod -R 644 /etc/cron.d/*
sudo chmod 644 /etc/crontab
sudo chmod 644 /etc/cron.hourly/*
sudo chmod 644 /etc/cron.daily/*
sudo chmod 644 /etc/cron.weekly/*
sudo chmod 644 /etc/cron.monthly/*
sudo chown -R root:root /etc/cron.*
```

In all cases, the principle of least privilege should be applied - system files and directories should be owned by root and only writable by root, with restrictive read permissions as appropriate for the file's purpose.

**Grading Notes:** Award up to 5 points based on:
- Clear explanation of how weak permissions enable privilege escalation (1 point)
- Example 1 with proper technical details and securing method (2 points)
- Example 2 with proper technical details and securing method (2 points)
- Additional points for extra examples or particularly insightful analysis
