# Linux User Management Security Guide

This guide covers the fundamental concepts and techniques for managing user accounts securely on Linux systems. Proper user account management is a critical component of Linux security and is frequently a focus area in CyberPatriot competitions.

## Table of Contents

- [Understanding Linux User Accounts](#understanding-linux-user-accounts)
- [Key User Management Files](#key-user-management-files)
- [Identifying and Auditing User Accounts](#identifying-and-auditing-user-accounts)
- [Managing User Accounts](#managing-user-accounts)
- [Password Policies and Authentication](#password-policies-and-authentication)
- [Group Management](#group-management)
- [Sudo and Root Access](#sudo-and-root-access)
- [Login Security](#login-security)
- [Account Monitoring and Auditing](#account-monitoring-and-auditing)
- [Common CyberPatriot Scenarios](#common-cyberpatriot-scenarios)
- [Best Practices Summary](#best-practices-summary)

## Understanding Linux User Accounts

In Linux, there are several types of user accounts:

1. **Root User (UID 0)**
   - The superuser or administrative account
   - Has complete control over the system
   - Can execute any command and access any file
   - Should be used with extreme caution

2. **System Users**
   - Created for specific services or applications
   - Usually have UIDs between 1-999 (Ubuntu/Debian) or 1-499 (Red Hat)
   - Often have no login shell or home directory
   - Examples: www-data, sshd, nobody

3. **Regular Users**
   - Standard user accounts for people using the system
   - Usually have UIDs 1000+ (Ubuntu/Debian) or 500+ (Red Hat)
   - Have a home directory and login shell
   - Limited permissions by default

Understanding these account types is essential for proper security implementation.

## Key User Management Files

Linux stores user information in several important files:

1. **/etc/passwd**
   - Contains basic user account information
   - Format: `username:x:UID:GID:comment:home_directory:shell`
   - Readable by all users, but only writable by root
   - The 'x' in the second field indicates the password is stored in /etc/shadow

2. **/etc/shadow**
   - Contains encrypted password information
   - Format: `username:encrypted_password:last_change:min_days:max_days:warn_days:inactive_days:expire_date:reserved`
   - Only readable and writable by root
   - More secure than the historical approach of storing passwords in /etc/passwd

3. **/etc/group**
   - Contains group information
   - Format: `groupname:x:GID:user_list`
   - Lists all groups and their members

4. **/etc/sudoers** and **/etc/sudoers.d/**
   - Configure which users can use sudo and what commands they can run
   - Should always be edited using the `visudo` command

5. **/etc/login.defs**
   - Defines system-wide login policies
   - Controls password aging, UID/GID ranges, etc.

6. **/etc/pam.d/**
   - PAM (Pluggable Authentication Modules) configuration
   - Controls authentication mechanisms

## Identifying and Auditing User Accounts

Before making changes to user accounts, first identify all existing accounts on the system:

### List All User Accounts

```bash
# Show all users from /etc/passwd
cat /etc/passwd

# Show only usernames
cut -d: -f1 /etc/passwd

# Show only human user accounts (UID 1000+)
awk -F: '$3 >= 1000 {print $1}' /etc/passwd

# Show system accounts
awk -F: '$3 < 1000 && $3 > 0 {print $1}' /etc/passwd
```

### Check for Users with Login Shells

```bash
# List users with login shells
grep -v '/nologin\|/false' /etc/passwd

# Show users with bash shell
grep '/bash' /etc/passwd
```

### Check for Users with UID 0 (Root Access)

```bash
# Find all users with UID 0 (should only be root)
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

### Identify Recently Created Accounts

```bash
# Check account creation info in /etc/shadow
sudo ls -la /etc/shadow

# Look at login records
last
```

### Check Group Memberships

```bash
# Show all groups
cat /etc/group

# Show groups for a specific user
groups username

# Show all users in a specific group
getent group groupname
```

### Check Sudo Access

```bash
# Show sudo configuration
sudo cat /etc/sudoers

# Check sudoers.d directory
sudo ls -la /etc/sudoers.d/

# Show all users with sudo access
grep -Po '^sudo:.*:\K.*$' /etc/group
```

## Managing User Accounts

### Adding a New User

```bash
# Basic user creation
sudo adduser username

# Create user with specific settings
sudo useradd -m -s /bin/bash -c "Full Name" username

# Create system user
sudo useradd -r -s /usr/sbin/nologin servicename
```

The `adduser` command is more user-friendly and interactive, while `useradd` is more suitable for scripting.

### Modifying Users

```bash
# Change username
sudo usermod -l new_username old_username

# Change user's home directory
sudo usermod -d /new/home/dir -m username

# Change user's shell
sudo usermod -s /bin/bash username

# Lock a user account
sudo usermod -L username
# or
sudo passwd -l username

# Unlock a user account
sudo usermod -U username
# or
sudo passwd -u username
```

### Deleting Users

```bash
# Delete user but keep home directory
sudo userdel username

# Delete user and home directory
sudo userdel -r username

# Delete user fully (home dir and mail spool)
sudo deluser --remove-home --remove-all-files username
```

## Password Policies and Authentication

### Setting and Changing Passwords

```bash
# Change your own password
passwd

# Change another user's password (as root)
sudo passwd username

# Force user to change password at next login
sudo passwd -e username

# Set empty password (highly insecure, avoid this)
sudo passwd -d username
```

### Password Policy Configuration

Password policies can be configured using PAM (Pluggable Authentication Modules).

1. **Install libpam-pwquality**
   ```bash
   sudo apt update
   sudo apt install libpam-pwquality
   ```

2. **Edit PAM configuration for password quality**
   ```bash
   sudo nano /etc/pam.d/common-password
   ```

   Look for the line containing `pam_pwquality.so` and add parameters:
   ```
   password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root
   ```

   These parameters mean:
   - `retry=3`: Allow 3 attempts before failure
   - `minlen=12`: Minimum password length of 12 characters
   - `difok=3`: At least 3 characters must be different from old password
   - `ucredit=-1`: Require at least 1 uppercase letter
   - `lcredit=-1`: Require at least 1 lowercase letter
   - `dcredit=-1`: Require at least 1 digit
   - `ocredit=-1`: Require at least 1 special character
   - `reject_username`: Reject passwords containing the username
   - `enforce_for_root`: Apply policy even for root user

3. **Configure Password Aging**
   ```bash
   sudo nano /etc/login.defs
   ```

   Modify these values:
   ```
   PASS_MAX_DAYS   90   # Maximum password age in days
   PASS_MIN_DAYS   7    # Minimum days between password changes
   PASS_WARN_AGE   14   # Days warning before password expires
   ```

   Apply to existing accounts:
   ```bash
   sudo chage -M 90 -m 7 -W 14 username
   ```

4. **Check Password Expiry Information**
   ```bash
   sudo chage -l username
   ```

## Group Management

### Creating and Managing Groups

```bash
# Create a new group
sudo groupadd groupname

# Delete a group
sudo groupdel groupname

# Modify a group
sudo groupmod -n new_groupname old_groupname
```

### Managing Group Membership

```bash
# Add a user to a group
sudo usermod -aG groupname username
# or
sudo adduser username groupname

# Remove a user from a group
sudo deluser username groupname
# or
sudo gpasswd -d username groupname

# Change a user's primary group
sudo usermod -g groupname username
```

### Important Groups to Monitor

Pay special attention to these security-sensitive groups:

- **sudo**: Members have sudo privilege
- **adm**: Members can read log files
- **wheel**: On some distributions, similar to sudo
- **admin**: Administrative access on some distributions
- **lxd/docker**: Potential privilege escalation vectors
- **shadow**: Can read shadow password file
- **root**: Members have root group permissions

## Sudo and Root Access

The `sudo` command allows users to run commands with the security privileges of another user, typically the superuser.

### Configuring Sudo Access

1. **Edit the sudoers file**
   ```bash
   sudo visudo
   ```

   Never edit `/etc/sudoers` directly; always use `visudo`.

2. **Examples of sudo configurations**:

   - Give a user full sudo privileges:
     ```
     username ALL=(ALL:ALL) ALL
     ```

   - Allow a user to run sudo without a password (insecure):
     ```
     username ALL=(ALL:ALL) NOPASSWD: ALL
     ```

   - Allow a user to run only specific commands:
     ```
     username ALL=(ALL:ALL) /bin/ls, /usr/bin/apt
     ```

   - Give a group sudo access:
     ```
     %groupname ALL=(ALL:ALL) ALL
     ```

3. **Create a custom sudo file for a user**
   ```bash
   sudo visudo -f /etc/sudoers.d/username
   ```

### Disabling Root Login

It's a security best practice to disable direct root login:

1. **Lock the root account**
   ```bash
   sudo passwd -l root
   ```

2. **Disable root login via SSH**
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

   Set:
   ```
   PermitRootLogin no
   ```

   Then restart SSH:
   ```bash
   sudo systemctl restart ssh
   ```

## Login Security

### Secure SSH Configuration

1. **Edit SSH configuration**
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

2. **Recommended settings**:
   ```
   PermitRootLogin no
   PasswordAuthentication no  # If using key-based authentication
   PubkeyAuthentication yes
   AuthorizedKeysFile .ssh/authorized_keys
   Protocol 2
   PermitEmptyPasswords no
   MaxAuthTries 5
   ClientAliveInterval 300
   ClientAliveCountMax 0
   LoginGraceTime 60
   AllowUsers user1 user2  # Whitelist approach
   ```

3. **Restart SSH after changes**
   ```bash
   sudo systemctl restart ssh
   ```

### Login Message and Banners

1. **Create a legal login banner**
   ```bash
   sudo nano /etc/issue  # Pre-login banner
   sudo nano /etc/issue.net  # SSH pre-login banner
   sudo nano /etc/motd  # Post-login message
   ```

2. **Enable the SSH banner**
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

   Add or uncomment:
   ```
   Banner /etc/issue.net
   ```

### Restricting Terminal Access

```bash
# Change user's shell to disable login
sudo usermod -s /usr/sbin/nologin username
# or
sudo usermod -s /bin/false username
```

## Account Monitoring and Auditing

### Monitor Login Activity

```bash
# View successful logins
last

# View failed login attempts
lastb

# View current logged-in users
who
w

# Check login records for a specific user
last username
```

### Enable User Login Auditing

1. **Configure auditd**
   ```bash
   sudo apt install auditd
   sudo systemctl enable auditd
   sudo systemctl start auditd
   ```

2. **Add user monitoring rules**
   ```bash
   sudo nano /etc/audit/rules.d/user-monitoring.rules
   ```

   Add:
   ```
   -w /etc/passwd -p wa -k user_modification
   -w /etc/shadow -p wa -k user_modification
   -w /etc/group -p wa -k user_modification
   -w /etc/gshadow -p wa -k user_modification
   -w /etc/sudoers -p wa -k user_modification
   -w /etc/sudoers.d/ -p wa -k user_modification
   ```

3. **Restart auditd**
   ```bash
   sudo systemctl restart auditd
   ```

4. **View audit logs**
   ```bash
   sudo ausearch -k user_modification
   ```

## Common CyberPatriot Scenarios

### Scenario 1: Unauthorized User Accounts

**Challenge:** You find unknown user accounts on the system.

**Solution:**
1. First, check which users are authorized (in the CyberPatriot README)
2. Identify unauthorized accounts:
   ```bash
   # List all human users
   awk -F: '$3 >= 1000 {print $1}' /etc/passwd
   ```
3. Check if unauthorized users have sudo privileges:
   ```bash
   sudo grep -Po '^sudo:.*:\K.*$' /etc/group
   ```
4. Back up before removing:
   ```bash
   sudo cp /etc/passwd /etc/passwd.bak
   sudo cp /etc/shadow /etc/shadow.bak
   sudo cp /etc/group /etc/group.bak
   ```
5. Remove unauthorized accounts:
   ```bash
   sudo userdel -r unauthorized_user
   ```

### Scenario 2: Root Access Audit

**Challenge:** You need to ensure only authorized users have root/sudo access.

**Solution:**
1. Check for users with UID 0:
   ```bash
   awk -F: '$3 == 0 {print $1}' /etc/passwd
   ```
2. Examine sudo access:
   ```bash
   grep -Po '^sudo:.*:\K.*$' /etc/group
   sudo ls -la /etc/sudoers.d/
   sudo grep -v '^#\|^$' /etc/sudoers
   ```
3. Remove unauthorized sudo access:
   ```bash
   sudo deluser unauthorized_user sudo
   # Or edit sudoers file with visudo:
   sudo visudo
   ```

### Scenario 3: Weak Password Policies

**Challenge:** The password policies do not meet security requirements.

**Solution:**
1. Install password quality module:
   ```bash
   sudo apt install libpam-pwquality
   ```
2. Configure password policies:
   ```bash
   sudo nano /etc/pam.d/common-password
   ```
   Add/modify:
   ```
   password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root
   ```
3. Set password aging:
   ```bash
   sudo nano /etc/login.defs
   ```
   Modify:
   ```
   PASS_MAX_DAYS   90
   PASS_MIN_DAYS   7
   PASS_WARN_AGE   14
   ```
4. Apply to existing accounts:
   ```bash
   for user in $(cut -d: -f1 /etc/passwd); do sudo chage -M 90 -m 7 -W 14 $user; done
   ```

### Scenario 4: SSH Security Issues

**Challenge:** SSH is configured insecurely.

**Solution:**
1. Edit SSH configuration:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```
2. Make these changes:
   ```
   Protocol 2
   PermitRootLogin no
   PermitEmptyPasswords no
   MaxAuthTries 5
   PasswordAuthentication yes  # Change to no if using key auth
   ```
3. Restart SSH:
   ```bash
   sudo systemctl restart ssh
   ```

## Best Practices Summary

1. **Regular User Account Audit**
   - Regularly review all user accounts and their privileges
   - Remove or disable accounts no longer needed
   - Ensure system accounts have login shells disabled

2. **Principle of Least Privilege**
   - Grant users only the permissions they need
   - Limit sudo access to essential users only
   - Use sudo with specific command restrictions where possible

3. **Strong Password Policies**
   - Enforce complex passwords (length, complexity)
   - Implement password aging
   - Consider using key-based authentication for SSH

4. **Secure the Root Account**
   - Disable direct root login, especially via SSH
   - Ensure only root has UID 0
   - Use sudo instead of direct root login

5. **Monitor User Activities**
   - Enable login auditing
   - Regularly check authentication logs
   - Watch for unusual login patterns or times

6. **SSH Hardening**
   - Disable root login via SSH
   - Consider key-based authentication instead of passwords
   - Restrict SSH access to specific users

7. **Regular Security Updates**
   - Keep the authentication system updated
   - Apply security patches to PAM and OpenSSH

Follow these best practices to maintain a secure user management environment on Linux systems, which is critical for success in CyberPatriot competitions.

## Additional Resources

- [Ubuntu User Management Documentation](https://help.ubuntu.com/community/AddUsersHowto)
- [Linux PAM Documentation](http://www.linux-pam.org/Linux-PAM-html/Linux-PAM_SAG.html)
- [CIS Benchmark for Linux User Security](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NIST Guidelines for Account Management](https://csrc.nist.gov/publications/detail/sp/800-123/final)
