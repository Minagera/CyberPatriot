# Linux System Hardening Guide for Ubuntu and Linux Mint

This intermediate guide covers essential techniques for hardening Ubuntu and Linux Mint systems against security threats. System hardening is a critical component of defense-in-depth security strategy and a major focus area in CyberPatriot competitions.

## Table of Contents

- [Introduction to System Hardening](#introduction-to-system-hardening)
- [Update and Patch Management](#update-and-patch-management)
- [Service Hardening](#service-hardening)
- [Boot Security](#boot-security)
- [File System Security](#file-system-security)
- [Network Hardening](#network-hardening)
- [Application Security](#application-security)
- [Auditing and Monitoring](#auditing-and-monitoring)
- [System Hardening Automation](#system-hardening-automation)
- [CyberPatriot Hardening Strategies](#cyberpatriot-hardening-strategies)

## Introduction to System Hardening

System hardening is the process of securing a system by reducing its attack surface and eliminating potential security vulnerabilities. It involves:

1. **Minimizing exposure**: Removing unnecessary services, features, and components
2. **Restricting access**: Implementing strong access controls
3. **Applying security updates**: Keeping the system patched against known vulnerabilities
4. **Following best practices**: Implementing industry-standard security configurations
5. **Monitoring and auditing**: Tracking system activities and changes

The goal is to establish a secure baseline configuration that meets security requirements while still allowing the system to perform its intended functions.

## Update and Patch Management

Keeping your Ubuntu or Linux Mint system updated is one of the most critical security practices.

### Package Management

```bash
# Update package lists
sudo apt update

# Upgrade all packages
sudo apt upgrade

# Full system upgrade (including package removals)
sudo apt full-upgrade

# Security-only updates (Ubuntu)
sudo apt upgrade -s | grep -i security
sudo apt upgrade -s | grep -i security | awk '{print $2}' | xargs sudo apt install
```

### Automatic Updates Configuration

1. Install automatic updates package:
   ```bash
   sudo apt install unattended-upgrades
   ```

2. Configure unattended upgrades:
   ```bash
   sudo nano /etc/apt/apt.conf.d/50unattended-upgrades
   ```

   Ensure the following line is uncommented:
   ```
   "${distro_id}:${distro_codename}-security";
   ```

3. Enable automatic updates:
   ```bash
   sudo nano /etc/apt/apt.conf.d/20auto-upgrades
   ```

   Add or modify:
   ```
   APT::Periodic::Update-Package-Lists "1";
   APT::Periodic::Download-Upgradeable-Packages "1";
   APT::Periodic::AutocleanInterval "7";
   APT::Periodic::Unattended-Upgrade "1";
   ```

4. Test configuration:
   ```bash
   sudo unattended-upgrades --dry-run
   ```

## Service Hardening

### Identifying and Managing Services

```bash
# List all services
systemctl list-units --type=service

# List all active services
systemctl list-units --type=service --state=active

# List services that start at boot
systemctl list-unit-files --type=service | grep enabled
```

### Disabling Unnecessary Services

```bash
# Stop a service
sudo systemctl stop service_name

# Disable a service (prevent from starting at boot)
sudo systemctl disable service_name

# Both stop and disable
sudo systemctl disable --now service_name
```

### Common Services to Review in Ubuntu/Linux Mint

Review these services and disable them if not needed:

- **telnet-server**: Insecure plain-text protocol
- **vsftpd**: If FTP is not required, or use SFTP instead
- **cups**: Printing service (if not using printers)
- **avahi-daemon**: mDNS/DNS-SD service discovery (unnecessary in many environments)
- **rpcbind**: If not using Network File System
- **smbd/nmbd**: If not using Samba file sharing
- **apache2/nginx**: Web servers (if not hosting websites)
- **mysql/mariadb/postgresql**: Database servers (if not needed)
- **bluetooth**: Bluetooth service (if not using Bluetooth devices)
- **isc-dhcp-server**: DHCP server (unless specifically required)

### Securing SSH

SSH is a critical service that often needs to remain enabled but securely configured:

1. Edit SSH configuration:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

2. Implement these security settings:
   ```
   # Use modern protocol
   Protocol 2
   
   # Restrict root login
   PermitRootLogin no
   
   # Use key authentication instead of passwords
   PasswordAuthentication no
   PubkeyAuthentication yes
   
   # Disable empty passwords
   PermitEmptyPasswords no
   
   # Limit login attempts
   MaxAuthTries 3
   
   # Set login grace time
   LoginGraceTime 60
   
   # Enable strict mode
   StrictModes yes
   
   # Specify allowed users (if applicable)
   AllowUsers user1 user2
   
   # Specify allowed groups (if applicable)
   AllowGroups sshusers sudo
   
   # Set idle timeout (5 minutes)
   ClientAliveInterval 300
   ClientAliveCountMax 0
   
   # Disable X11 forwarding if not needed
   X11Forwarding no
   
   # Use strong ciphers and MACs
   Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr
   MACs hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256
   
   # Log more verbosely
   LogLevel VERBOSE
   ```

3. Restart SSH after changes:
   ```bash
   sudo systemctl restart ssh
   ```

## Boot Security

### GRUB Bootloader Security

1. Set bootloader password:
   ```bash
   sudo grub-mkpasswd-pbkdf2
   ```

2. Edit GRUB configuration:
   ```bash
   sudo nano /etc/grub.d/40_custom
   ```

3. Add these lines with the hash from the previous command:
   ```
   set superusers="root"
   password_pbkdf2 root grub.pbkdf2.sha512.10000.HASH_FROM_COMMAND
   ```

4. Update GRUB:
   ```bash
   sudo update-grub
   ```

### Kernel Hardening Parameters

1. Edit sysctl configuration:
   ```bash
   sudo nano /etc/sysctl.d/99-security.conf
   ```

2. Add these parameters:
   ```
   # Restrict kernel pointer access
   kernel.kptr_restrict=2
   
   # Restrict access to kernel logs
   kernel.dmesg_restrict=1
   
   # Protect against SYN flood attacks
   net.ipv4.tcp_syncookies=1
   
   # Enable source route validation
   net.ipv4.conf.all.rp_filter=1
   net.ipv4.conf.default.rp_filter=1
   
   # Disable IP forwarding (unless router/firewall)
   net.ipv4.ip_forward=0
   
   # Disable source routing
   net.ipv4.conf.all.accept_source_route=0
   net.ipv4.conf.default.accept_source_route=0
   
   # Disable ICMP redirect acceptance
   net.ipv4.conf.all.accept_redirects=0
   net.ipv4.conf.default.accept_redirects=0
   
   # Disable secure ICMP redirect acceptance
   net.ipv4.conf.all.secure_redirects=0
   net.ipv4.conf.default.secure_redirects=0
   
   # Log martian packets
   net.ipv4.conf.all.log_martians=1
   net.ipv4.conf.default.log_martians=1
   
   # Ignore broadcast ICMP
   net.ipv4.icmp_echo_ignore_broadcasts=1
   
   # Ignore bogus ICMP error responses
   net.ipv4.icmp_ignore_bogus_error_responses=1
   
   # Enable TCP SYN cookies
   net.ipv4.tcp_syncookies=1
   ```

3. Apply the settings:
   ```bash
   sudo sysctl -p /etc/sysctl.d/99-security.conf
   ```

### Restrict Module Loading

To prevent unauthorized kernel modules from loading:

1. Create a configuration file:
   ```bash
   sudo nano /etc/modprobe.d/blacklist-modules.conf
   ```

2. Add blacklisted modules:
   ```
   # Blacklist uncommon network protocols
   blacklist sctp
   blacklist rds
   blacklist tipc
   
   # Blacklist uncommon file systems
   blacklist cramfs
   blacklist freevxfs
   blacklist jffs2
   blacklist hfs
   blacklist hfsplus
   blacklist udf
   ```

## File System Security

### Secure Mount Options

1. Edit the file system table:
   ```bash
   sudo nano /etc/fstab
   ```

2. Add secure mount options to partitions:
   ```
   # Example for /tmp partition
   UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /tmp ext4 defaults,nodev,nosuid,noexec 0 2
   
   # Example for /var partition
   UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /var ext4 defaults,nodev 0 2
   
   # Example for /home partition
   UUID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx /home ext4 defaults,nodev 0 2
   ```

The options mean:
- `nodev`: Prevent device files from being interpreted as device files
- `nosuid`: Prevent SUID/SGID bit execution
- `noexec`: Prevent direct execution of binaries

### Temporary File Systems Security

1. Create/edit tmpfs configuration:
   ```bash
   sudo nano /etc/systemd/system/tmp.mount
   ```

2. Add configuration:
   ```
   [Unit]
   Description=Temporary Directory /tmp
   Documentation=man:hier(7)
   After=local-fs.target
   
   [Mount]
   What=tmpfs
   Where=/tmp
   Type=tmpfs
   Options=mode=1777,strictatime,nodev,nosuid,noexec,size=2G
   
   [Install]
   WantedBy=multi-user.target
   ```

3. Enable the mount:
   ```bash
   sudo systemctl enable tmp.mount
   sudo systemctl start tmp.mount
   ```

### Securing World-Writable Directories

```bash
# Find world-writable directories
sudo find / -type d -perm -o+w -print

# Secure /tmp and /var/tmp sticky bit
sudo chmod 1777 /tmp
sudo chmod 1777 /var/tmp
```

### Checking for SUID/SGID Files

```bash
# Find SUID files
sudo find / -type f -perm -4000 -print

# Find SGID files
sudo find / -type f -perm -2000 -print
```

Review these files and remove the SUID/SGID bits if not necessary:
```bash
sudo chmod u-s /path/to/file  # Remove SUID
sudo chmod g-s /path/to/file  # Remove SGID
```

## Network Hardening

### Firewall Configuration with UFW

Uncomplicated Firewall (UFW) is the default firewall in Ubuntu and Linux Mint:

```bash
# Install UFW if not already installed
sudo apt install ufw

# Set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (modify port if needed)
sudo ufw allow 22/tcp

# Allow other necessary services
# sudo ufw allow 80/tcp  # HTTP
# sudo ufw allow 443/tcp  # HTTPS

# Enable the firewall
sudo ufw enable

# Check status
sudo ufw status verbose
```

### Checking Open Ports

Verify which ports are open and listening:

```bash
# Install net-tools if needed
sudo apt install net-tools

# Check open ports
sudo netstat -tulpn

# Alternative using ss
sudo ss -tulpn
```

### IPv6 Configuration

If you're not using IPv6, consider disabling it:

1. Edit sysctl configuration:
   ```bash
   sudo nano /etc/sysctl.d/99-disable-ipv6.conf
   ```

2. Add:
   ```
   net.ipv6.conf.all.disable_ipv6 = 1
   net.ipv6.conf.default.disable_ipv6 = 1
   net.ipv6.conf.lo.disable_ipv6 = 1
   ```

3. Apply:
   ```bash
   sudo sysctl -p /etc/sysctl.d/99-disable-ipv6.conf
   ```

## Application Security

### Installing and Using AppArmor

AppArmor is a Mandatory Access Control (MAC) system included in Ubuntu and Linux Mint:

```bash
# Install AppArmor utilities
sudo apt install apparmor-utils

# Check status
sudo aa-status

# Enable AppArmor
sudo systemctl enable apparmor
sudo systemctl start apparmor

# Set profiles to enforce mode
sudo aa-enforce /etc/apparmor.d/*
```

### Securing Web Servers

If running Apache web server:

1. Secure configuration:
   ```bash
   sudo nano /etc/apache2/conf-available/security.conf
   ```

   Add/modify:
   ```
   # Hide server information
   ServerTokens Prod
   ServerSignature Off
   
   # Disable directory browsing
   <Directory />
       Options -Indexes
   </Directory>
   
   # Disable TRACE method
   TraceEnable Off
   ```

2. Enable security configuration:
   ```bash
   sudo a2enconf security
   sudo systemctl restart apache2
   ```

## Auditing and Monitoring

### Setting Up Auditd

The Linux Audit system provides fine-grained logging:

```bash
# Install audit system
sudo apt install auditd

# Enable and start
sudo systemctl enable auditd
sudo systemctl start auditd
```

Create basic audit rules:
```bash
sudo nano /etc/audit/rules.d/audit.rules
```

Add:
```
# Delete all rules
-D

# Buffer Size
-b 8192

# Failure Mode
-f 1

# Monitor user/group changes
-w /etc/group -p wa -k identity
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity

# Monitor network changes
-w /etc/hosts -p wa -k system-locale
-w /etc/network -p wa -k system-locale

# Monitor changes to sudoers
-w /etc/sudoers -p wa -k sudoers
-w /etc/sudoers.d/ -p wa -k sudoers

# Make the configuration immutable
-e 2
```

Restart auditd:
```bash
sudo systemctl restart auditd
```

View audit logs:
```bash
sudo ausearch -k identity  # Search for identity-related events
sudo aureport -au          # Authentication report
```

### Setting Up Fail2ban

Fail2ban helps protect against brute force attacks:

```bash
# Install fail2ban
sudo apt install fail2ban

# Create local configuration
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# Edit configuration
sudo nano /etc/fail2ban/jail.local
```

Modify settings for SSH:
```
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
```

Start and enable the service:
```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### Checking for Rootkits

Install and run rootkit detection tools:

```bash
# Install rkhunter
sudo apt install rkhunter

# Update rkhunter database
sudo rkhunter --update

# Run a check
sudo rkhunter --check

# Install chkrootkit
sudo apt install chkrootkit

# Run chkrootkit
sudo chkrootkit
```

## System Hardening Automation

### Creating a Basic Hardening Script for Ubuntu/Linux Mint

Here's a simple script that implements many of the hardening techniques discussed:

```bash
#!/bin/bash
# Basic System Hardening Script for Ubuntu/Linux Mint
# Run as root

echo "Starting Ubuntu/Linux Mint system hardening..."

# Update system packages
echo "Updating packages..."
apt update
apt upgrade -y

# Install security tools
echo "Installing security tools..."
apt install -y ufw fail2ban auditd rkhunter chkrootkit apparmor-utils unattended-upgrades

# Configure UFW
echo "Configuring firewall..."
ufw default deny incoming
ufw default allow outgoing
ufw allow 22/tcp
ufw --force enable

# Secure SSH
echo "Securing SSH..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sed -i 's/^#PermitRootLogin .*/PermitRootLogin no/' /etc/ssh/sshd_config
sed -i 's/^#PasswordAuthentication .*/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^X11Forwarding .*/X11Forwarding no/' /etc/ssh/sshd_config
echo "Protocol 2" >> /etc/ssh/sshd_config
echo "MaxAuthTries 3" >> /etc/ssh/sshd_config
echo "PermitEmptyPasswords no" >> /etc/ssh/sshd_config
systemctl restart sshd

# Secure kernel with sysctl
echo "Hardening kernel parameters..."
cat > /etc/sysctl.d/99-security.conf << EOF
kernel.kptr_restrict=2
kernel.dmesg_restrict=1
net.ipv4.conf.all.rp_filter=1
net.ipv4.conf.default.rp_filter=1
net.ipv4.tcp_syncookies=1
net.ipv4.conf.all.accept_redirects=0
net.ipv4.conf.default.accept_redirects=0
net.ipv4.conf.all.secure_redirects=0
net.ipv4.conf.default.secure_redirects=0
net.ipv4.conf.all.accept_source_route=0
net.ipv4.conf.default.accept_source_route=0
net.ipv4.icmp_echo_ignore_broadcasts=1
net.ipv4.icmp_ignore_bogus_error_responses=1
EOF
sysctl -p /etc/sysctl.d/99-security.conf

# Secure file permissions
echo "Securing file permissions..."
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/passwd
chmod 644 /etc/group
chmod 700 /root
chmod 700 /var/log/audit

# Configure automatic updates
echo "Setting up automatic updates..."
cat > /etc/apt/apt.conf.d/20auto-upgrades << EOF
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# Enable AppArmor
echo "Enabling AppArmor..."
systemctl enable apparmor
systemctl start apparmor

# Configure auditd
echo "Configuring auditd..."
cat > /etc/audit/rules.d/hardening.rules << EOF
-w /etc/passwd -p wa -k identity
-w /etc/shadow -p wa -k identity
-w /etc/group -p wa -k identity
-w /etc/gshadow -p wa -k identity
-w /etc/sudoers -p wa -k sudoers
-w /etc/sudoers.d/ -p wa -k sudoers
EOF
systemctl restart auditd

# Configure fail2ban for SSH
echo "Configuring fail2ban..."
cat > /etc/fail2ban/jail.local << EOF
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
findtime = 600
EOF
systemctl restart fail2ban

# Secure /tmp
echo "Securing /tmp..."
cat > /etc/systemd/system/tmp.mount << EOF
[Unit]
Description=Temporary Directory /tmp
Documentation=man:hier(7)
After=local-fs.target

[Mount]
What=tmpfs
Where=/tmp
Type=tmpfs
Options=mode=1777,strictatime,nodev,nosuid,noexec,size=2G

[Install]
WantedBy=multi-user.target
EOF
systemctl enable tmp.mount
systemctl start tmp.mount

# Secure sticky bit on world-writable directories
echo "Setting sticky bit on world-writable directories..."
chmod 1777 /tmp
chmod 1777 /var/tmp

echo "Basic system hardening completed!"
```

Save this script as `harden_ubuntu.sh`, make it executable, and run it as root:
```bash
sudo chmod +x harden_ubuntu.sh
sudo ./harden_ubuntu.sh
```

### Using Lynis for Security Auditing

Lynis is an open-source security auditing tool specifically helpful for Ubuntu and Linux Mint:

```bash
# Install Lynis
sudo apt install lynis

# Run an audit
sudo lynis audit system

# View audit report
sudo cat /var/log/lynis.log
```

## CyberPatriot Hardening Strategies

During a CyberPatriot competition on Ubuntu or Linux Mint, follow these strategic approaches:

### Initial Assessment

1. **Read the README**: Always start by reading the competition README file for specific requirements and prohibited changes.

2. **Snapshot the System**: If allowed, take a snapshot of the VM before making changes.

3. **Perform Initial Reconnaissance**:
   ```bash
   # List users and groups
   cat /etc/passwd
   cat /etc/group
   
   # Check sudo configuration
   sudo cat /etc/sudoers
   ls -la /etc/sudoers.d/
   
   # List running services
   systemctl list-units --type=service --state=active
   
   # Check for open ports
   sudo ss -tulpn
   
   # Check installed packages
   dpkg -l | grep -i server
   
   # Look for unusual files
   find / -type f -perm -4000 -ls 2>/dev/null
   find / -name "*.mp3" -o -name "*.jpg" -o -name "*.png" 2>/dev/null
   ```

### Prioritized Hardening

Focus on these areas in order:

1. **User Account Security**:
   - Remove/disable unauthorized users
   - Secure passwords
   - Configure sudo access properly

2. **Update and Patch**:
   - Apply all security updates
   - Enable automatic updates

3. **Service Hardening**:
   - Disable unnecessary services
   - Configure SSH securely
   - Secure required services

4. **Firewall Configuration**:
   - Enable and configure UFW
   - Allow only necessary ports

5. **Malware Removal**:
   - Check for unauthorized processes
   - Scan for malware with tools like chkrootkit or rkhunter

6. **Additional Security Measures**:
   - Configure auditd
   - Implement file system security
   - Apply kernel hardening
   - Set up fail2ban

### Common CyberPatriot Ubuntu/Linux Mint Tasks

These tasks frequently appear in competitions:

1. **Unauthorized Users/Groups**: 
   Check for and remove unauthorized users:
   ```bash
   # List all users with UID 1000 or higher (normal users)
   awk -F: '$3 >= 1000 {print $1}' /etc/passwd
   
   # Remove unauthorized user
   sudo userdel -r unauthorized_user
   ```

2. **Password Policies**: 
   Implement stronger password requirements with PAM:
   ```bash
   sudo apt install libpam-pwquality
   sudo nano /etc/pam.d/common-password
   # Look for and modify pam_pwquality.so line
   ```

3. **Unauthorized Software**: 
   Identify and remove unauthorized packages:
   ```bash
   # List installed packages
   dpkg -l | grep -i suspicious_term
   
   # Remove package
   sudo apt remove --purge package_name
   ```

4. **Insecure Services**: 
   Disable insecure services:
   ```bash
   # Check for telnet, FTP, etc.
   dpkg -l | grep -E 'telnet|ftp|rsh'
   
   # Disable service
   sudo systemctl disable --now service_name
   
   # Remove package
   sudo apt remove --purge package_name
   ```

5. **Suspicious Files**: 
   Locate and remove malware or media files:
   ```bash
   # Find files with specific extensions
   sudo find / -name "*.mp3" -o -name "*.avi" 2>/dev/null
   
   # Find files in unusual locations
   sudo find /var -name "*.sh" 2>/dev/null
   ```

6. **Firewall Configuration**: 
   Ensure UFW is enabled with proper rules:
   ```bash
   sudo ufw status verbose
   sudo ufw enable
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   sudo ufw allow ssh
   ```

7. **SSH Hardening**: 
   Secure the SSH server configuration:
   ```bash
   sudo nano /etc/ssh/sshd_config
   # Modify settings as needed
   sudo systemctl restart ssh
   ```

8. **Account Privileges**: 
   Ensure users have appropriate privileges:
   ```bash
   # Check sudo users
   grep -Po '^sudo:.*:\K.*$' /etc/group
   
   # Check admin group
   grep -Po '^adm:.*:\K.*$' /etc/group
   ```

9. **Forensic Questions**: 
   Answer questions about the system:
   ```bash
   # Check installation dates
   ls -la /var/log/installer
   
   # Check login history
   last
   
   # Check audit logs
   sudo ausearch -i
   ```

10. **System Hardening Verification**:
    Verify your hardening efforts:
    ```bash
    # Check service status
    systemctl list-units --type=service --state=active
    
    # Check firewall
    sudo ufw status
    
    # Check open ports
    sudo ss -tulpn
    ```

By following this guide, you'll be well-prepared to handle Ubuntu and Linux Mint security hardening tasks in CyberPatriot competitions.

## Additional Resources

- [Ubuntu Security Documentation](https://ubuntu.com/security)
- [Linux Mint Security Guide](https://linuxmint-user-guide.readthedocs.io/en/latest/security.html)
- [CIS Benchmarks for Ubuntu Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [CyberPatriot Linux Training Materials](https://www.uscyberpatriot.org/competition/training-materials/linux)
