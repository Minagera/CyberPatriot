# Linux Security Challenge - Solution Guide

This document provides complete solutions for the Linux Security Challenge exercise. It includes all security issues in the challenge VM and detailed steps to remediate each one.

**Note to Mentors**: This solution guide is for instructor use only. Students should attempt to solve the challenge on their own before consulting this document.

## Initial Assessment

The challenge VM contains several intentional security issues:

### User Issues
- Unauthorized user accounts
- Improper sudo access
- Weak password policies
- Hidden backdoor account

### Service Issues
- Insecurely configured SSH
- Unnecessary services running (telnet, FTP)
- Insecure web server configuration

### System Issues
- Missing security updates
- No firewall configuration
- Insecure kernel parameters
- Malicious scripts and cron jobs

## Part 1: User and Group Management Solutions

### Unauthorized Users

Check all user accounts:
```bash
cat /etc/passwd | grep -v nologin | grep -v false
```

Unauthorized users to remove:
```bash
sudo userdel -r hacker
sudo userdel -r testuser
sudo userdel -r tempuser
```

### Improper Group Memberships

Check sudo access:
```bash
grep -Po '^sudo:.*:\K.*$' /etc/group
```

Remove unauthorized users from sudo:
```bash
sudo deluser testuser sudo
sudo deluser operator sudo  # Unless specifically required
```

### Password Policies

Set strong password policies:
```bash
sudo apt install libpam-pwquality
sudo nano /etc/pam.d/common-password
```

Add/modify this line:
```
password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root
```

Configure password aging:
```bash
sudo nano /etc/login.defs
```

Set values:
```
PASS_MAX_DAYS   90
PASS_MIN_DAYS   7
PASS_WARN_AGE   14
```

Apply to existing accounts:
```bash
for user in $(cut -d: -f1 /etc/passwd); do sudo chage -M 90 -m 7 -W 14 $user; done
```

### Hidden Backdoor Account

Find the backdoor account:
```bash
grep -v nologin /etc/passwd | grep -v false
# or look for suspicious UIDs
awk -F: '$3 == 0 {print $1}' /etc/passwd
```

The backdoor is a root-level account named "sysadmin" with UID 0:
```bash
sudo userdel -r sysadmin
```

Check for unauthorized SSH keys:
```bash
find /home -name "authorized_keys" -exec cat {} \;
cat /root/.ssh/authorized_keys 2>/dev/null
```

Remove any unauthorized keys:
```bash
rm /home/user/.ssh/authorized_keys
# Or edit the file to remove specific keys
```

## Part 2: Service Security Solutions

### SSH Configuration

Secure SSH by editing `/etc/ssh/sshd_config`:
```bash
sudo nano /etc/ssh/sshd_config
```

Make these changes:
```
# Disable root login
PermitRootLogin no

# Use SSH Protocol 2 only
Protocol 2

# Disable password authentication if using keys
PasswordAuthentication yes  # Change to no if using key authentication

# Disable empty passwords
PermitEmptyPasswords no

# Limit authentication attempts
MaxAuthTries 3

# Set login grace time
LoginGraceTime 60

# Disable X11 forwarding
X11Forwarding no
```

Restart SSH:
```bash
sudo systemctl restart ssh
```

### Disable Unnecessary Services

Identify running services:
```bash
systemctl list-units --type=service --state=active
```

Disable telnet:
```bash
sudo apt purge telnetd telnet
# or
sudo systemctl stop telnetd
sudo systemctl disable telnetd
```

Disable FTP:
```bash
sudo apt purge vsftpd
# or
sudo systemctl stop vsftpd
sudo systemctl disable vsftpd
```

Check other unnecessary services and disable:
```bash
sudo systemctl disable --now avahi-daemon
sudo systemctl disable --now cups
# Add others as identified
```

### Web Server (if present)

Secure Apache:
```bash
sudo nano /etc/apache2/conf-available/security.conf
```

Make these changes:
```
# Disable server signature
ServerSignature Off
ServerTokens Prod

# Disable directory browsing
<Directory />
    Options -Indexes
</Directory>
```

Enable the security configuration:
```bash
sudo a2enconf security
sudo systemctl restart apache2
```

## Part 3: System Updates and Software Management

### System Updates

Update the system:
```bash
sudo apt update
sudo apt upgrade -y
```

Configure automatic updates:
```bash
sudo apt install unattended-upgrades
sudo nano /etc/apt/apt.conf.d/20auto-upgrades
```

Add:
```
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
```

### Unauthorized Software

Check for and remove unauthorized software:
```bash
dpkg -l | grep -i game  # Remove games if found
dpkg -l | grep -i torrent  # Remove torrent software
```

Install security tools:
```bash
sudo apt install ufw fail2ban rkhunter
```

## Part 4: Network Security

### Firewall Configuration

Configure UFW:
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
# Allow other necessary services
sudo ufw enable
```

Verify configuration:
```bash
sudo ufw status verbose
```

### Secure Network Settings

Configure secure sysctl settings:
```bash
sudo nano /etc/sysctl.d/99-security.conf
```

Add:
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

# Ignore broadcast ICMP
net.ipv4.icmp_echo_ignore_broadcasts=1
```

Apply the settings:
```bash
sudo sysctl -p /etc/sysctl.d/99-security.conf
```

## Part 5: System Hardening

### File System Security

Check for and fix SUID/SGID binaries:
```bash
# Find suspicious SUID binaries
sudo find / -type f -perm -4000 -ls 2>/dev/null

# Find suspicious SGID binaries
sudo find / -type f -perm -2000 -ls 2>/dev/null
```

Remove unnecessary SUID/SGID permissions:
```bash
sudo chmod u-s /path/to/unnecessary/suid/binary
sudo chmod g-s /path/to/unnecessary/sgid/binary
```

Secure temporary directories:
```bash
sudo chmod 1777 /tmp
sudo chmod 1777 /var/tmp
```

### Logging Configuration

Configure system logging:
```bash
sudo nano /etc/rsyslog.conf
```

Ensure these settings:
```
# Log auth messages
auth,authpriv.*                 /var/log/auth.log

# Log all kernel messages
kern.*                          /var/log/kern.log

# Log daemon messages
daemon.*                        /var/log/daemon.log
```

Configure log rotation:
```bash
sudo nano /etc/logrotate.conf
```

Ensure logs are rotated and retained:
```
rotate 14
```

### AppArmor Configuration

Enable and configure AppArmor:
```bash
sudo apt install apparmor-utils
sudo aa-enforce /etc/apparmor.d/*
```

## Part 6: Hidden Security Issues

### Suspicious Cron Job

Check for suspicious cron jobs:
```bash
sudo ls -la /etc/cron*
sudo cat /etc/crontab
sudo ls -la /var/spool/cron/crontabs/
for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l 2>/dev/null; done
```

The malicious cron job is located in `/etc/cron.d/system-update` and contains a reverse shell:
```bash
sudo rm /etc/cron.d/system-update
```

### Hidden Startup Script

Look for unusual startup scripts:
```bash
find /etc/init.d -type f | xargs ls -la
find /etc/init -type f | xargs ls -la
find /etc/systemd/system -type f | xargs ls -la
find /usr/lib/systemd/system -type f -mtime -30 | xargs ls -la
```

The hidden startup script is a systemd service file at `/etc/systemd/system/backdoor.service`:
```bash
sudo rm /etc/systemd/system/backdoor.service
sudo systemctl daemon-reload
```

### Unauthorized SSH Key

Check all authorized_keys files:
```bash
find / -name "authorized_keys" 2>/dev/null | xargs cat
```

Remove unauthorized keys from:
```bash
sudo rm /root/.ssh/authorized_keys
# or edit to remove specific keys
sudo nano /home/user/.ssh/authorized_keys
```

### Flag File

Search for the flag file:
```bash
find / -type f -name "*flag*" 2>/dev/null
grep -r "FLAG:" --include="*.txt" / 2>/dev/null
find / -type f -mtime -1 2>/dev/null | xargs grep -l "FLAG" 2>/dev/null
```

The flag is located in `/opt/.hidden/flag.txt`.

## Part 7: Additional Security Recommendations

Beyond the specific issues in the challenge, these additional security measures are recommended:

### Setting Up Fail2ban

Install and configure Fail2ban:
```bash
sudo apt install fail2ban
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

Configure SSH protection:
```
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 3600
```

Start and enable fail2ban:
```bash
sudo systemctl enable fail2ban
sudo systemctl start fail2ban
```

### File Integrity Monitoring with AIDE

Install and configure AIDE:
```bash
sudo apt install aide
sudo nano /etc/aide/aide.conf  # Customize as needed
sudo aideinit
sudo cp /var/lib/aide/aide.db.new /var/lib/aide/aide.db
sudo systemctl enable aide.timer  # On systems with systemd
```

### Create a Daily Security Check Script

Create a security check script at `/usr/local/bin/security-check.sh`:
```bash
#!/bin/bash
# Daily security check script

REPORT_FILE="/var/log/security-check-$(date +%F).log"

echo "Security Check Report - $(date)" > $REPORT_FILE
echo "================================" >> $REPORT_FILE

# Check for failed logins
echo "Recent failed login attempts:" >> $REPORT_FILE
grep "Failed password" /var/log/auth.log | tail -10 >> $REPORT_FILE

# Check for users with UID 0
echo "Users with UID 0:" >> $REPORT_FILE
awk -F: '$3 == 0 {print $1}' /etc/passwd >> $REPORT_FILE

# Check for changes to critical files
echo "Changes to critical files in the last 24 hours:" >> $REPORT_FILE
find /etc -type f -mtime -1 | grep -v "utmp\|wtmp" >> $REPORT_FILE

# Check for listening ports
echo "Listening ports:" >> $REPORT_FILE
ss -tulpn >> $REPORT_FILE

# Check for unusual SUID/SGID files
echo "Unusual SUID/SGID files:" >> $REPORT_FILE
find / -type f \( -perm -4000 -o -perm -2000 \) -exec ls -la {} \; 2>/dev/null | 
  grep -v "/bin/\|/usr/bin/\|/usr/sbin/" >> $REPORT_FILE

# Email the report to the administrator
mail -s "Security Check Report for $(hostname)" root < $REPORT_FILE
```

Make the script executable and set up a daily cron job:
```bash
sudo chmod +x /usr/local/bin/security-check.sh
echo "0 5 * * * root /usr/local/bin/security-check.sh" | sudo tee /etc/cron.d/security-check
```

## Complete Security Checklist

Use this checklist to verify you've addressed all issues:

### User Security
- [x] Removed unauthorized users: `hacker`, `testuser`, `tempuser`
- [x] Removed unauthorized sudo access
- [x] Discovered and removed backdoor account `sysadmin` with UID 0
- [x] Configured strong password policies
- [x] Set up password aging
- [x] Secured user home directories
- [x] Removed unauthorized SSH keys

### Service Security
- [x] Properly configured SSH
- [x] Disabled/removed telnet service
- [x] Disabled/removed FTP service
- [x] Secured Apache web server (if present)
- [x] Disabled unnecessary services (avahi-daemon, cups, etc.)
- [x] Checked and secured all enabled services
- [x] Removed suspicious startup service `backdoor.service`

### System Security
- [x] Updated all system packages
- [x] Configured automatic updates
- [x] Enabled and configured firewall (UFW)
- [x] Secured network settings with sysctl
- [x] Set appropriate file permissions
- [x] Configured system logging
- [x] Found and removed malicious cron job in `/etc/cron.d/system-update`
- [x] Located flag file at `/opt/.hidden/flag.txt`

### Bonus Security Measures
- [x] Installed and configured Fail2ban
- [x] Set up AIDE for file integrity monitoring
- [x] Created daily security check script
- [x] Enabled and configured AppArmor
- [x] Generated comprehensive security report

## Conclusion

This solution guide covers all the intentional security issues in the Linux Security Challenge. Remember that in a real CyberPatriot competition or production environment, you may encounter different or additional security issues. The methodical approach demonstrated here—assessing the system, prioritizing fixes, and verifying changes—is applicable to any Linux security scenario.

## Additional Notes for Mentors

- Consider having students present their findings and solutions to the group
- Discuss which issues were most difficult to find and why
- Highlight any creative solutions students developed
- Use the exercise results to guide future training sessions

## References

- [Ubuntu Security Documentation](https://ubuntu.com/security)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NSA Linux Hardening Guide](https://apps.nsa.gov/iaarchive/library/ia-guidance/security-configuration/operating-systems/guide-to-the-secure-configuration-of-red-hat-enterprise.cfm)
- [CyberPatriot Training Materials](https://www.uscyberpatriot.org/competition/training-materials/linux)
