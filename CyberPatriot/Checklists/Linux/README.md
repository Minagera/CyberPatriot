# Linux Security Checklist for Ubuntu/Linux Mint

This comprehensive checklist covers essential security configurations for Ubuntu and Linux Mint systems. Use it during CyberPatriot competitions to ensure you address all critical security aspects systematically.

## User Account Security

### Password and Authentication
- [ ] Set strong password for root account
  ```bash
  sudo passwd root
  ```
- [ ] Install password quality checking library
  ```bash
  sudo apt install libpam-pwquality
  ```
- [ ] Enforce password policies through PAM
  ```bash
  sudo nano /etc/pam.d/common-password
  # Add: password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1
  ```
- [ ] Configure password aging
  ```bash
  sudo nano /etc/login.defs
  # Set: PASS_MAX_DAYS 90
  # Set: PASS_MIN_DAYS 10
  # Set: PASS_WARN_AGE 7
  ```
- [ ] Apply password aging to existing users
  ```bash
  sudo chage -M 90 -m 10 -W 7 <username>
  ```
- [ ] Lock default accounts not requiring login
  ```bash
  sudo passwd -l <username>
  ```

### User Management
- [ ] Review all user accounts
  ```bash
  cat /etc/passwd
  ```
- [ ] Remove unauthorized or unnecessary users
  ```bash
  sudo userdel -r <username>
  ```
- [ ] Review all groups
  ```bash
  cat /etc/group
  ```
- [ ] Remove unnecessary groups
  ```bash
  sudo groupdel <groupname>
  ```
- [ ] Check sudo configuration
  ```bash
  sudo visudo
  # or
  sudo cat /etc/sudoers
  sudo cat /etc/sudoers.d/*
  ```
- [ ] Ensure only authorized users have sudo access
  ```bash
  sudo gpasswd -d <username> sudo
  ```
- [ ] Check for users with empty passwords
  ```bash
  sudo grep -E "^[^:]+::.*$" /etc/shadow
  ```
- [ ] Check for users with UID 0 (root privileges)
  ```bash
  sudo awk -F: '($3 == 0) {print}' /etc/passwd
  ```

## File System Security

### Permissions
- [ ] Find and secure world-writable files
  ```bash
  sudo find / -type f -perm -o+w -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" -exec ls -l {} \;
  ```
- [ ] Find and secure world-writable directories
  ```bash
  sudo find / -type d -perm -o+w -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" -not -path "/tmp/*" -exec ls -ld {} \;
  ```
- [ ] Find and remove unowned files
  ```bash
  sudo find / -nouser -o -nogroup -exec ls -l {} \;
  ```
- [ ] Check/set appropriate permissions for sensitive files
  ```bash
  sudo chmod 600 /etc/shadow
  sudo chmod 644 /etc/passwd
  sudo chmod 644 /etc/group
  sudo chmod 600 /etc/gshadow
  sudo chmod 644 /etc/ssh/sshd_config
  ```
- [ ] Check for SUID/SGID binaries
  ```bash
  sudo find / -type f \( -perm -4000 -o -perm -2000 \) -exec ls -l {} \;
  ```

### Temporary Files
- [ ] Secure /tmp directory
  ```bash
  sudo mount -o remount,noexec,nosuid,rw /tmp
  ```
- [ ] Add to /etc/fstab for persistence
  ```bash
  echo "tmpfs /tmp tmpfs defaults,noexec,nosuid 0 0" | sudo tee -a /etc/fstab
  ```

## System Security

### Firewall (UFW)
- [ ] Install UFW if not already installed
  ```bash
  sudo apt install ufw
  ```
- [ ] Enable and configure firewall
  ```bash
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  sudo ufw allow ssh
  sudo ufw enable
  ```
- [ ] Check firewall status
  ```bash
  sudo ufw status verbose
  ```

### Service Management
- [ ] List all running services
  ```bash
  sudo systemctl list-units --type=service --state=active
  ```
- [ ] Disable unnecessary services
  ```bash
  sudo systemctl disable <service>
  sudo systemctl stop <service>
  ```
- [ ] Remove unnecessary packages/applications
  ```bash
  sudo apt purge <package>
  sudo apt autoremove
  ```

### SSH Configuration
- [ ] Secure SSH configuration
  ```bash
  sudo nano /etc/ssh/sshd_config
  ```
  
  Edit these settings:
  ```
  PermitRootLogin no
  Protocol 2
  PasswordAuthentication yes  # Set to 'no' if using key authentication
  X11Forwarding no
  MaxAuthTries 3
  PubkeyAuthentication yes
  PermitEmptyPasswords no
  ClientAliveInterval 300
  ClientAliveCountMax 0
  LoginGraceTime 60
  ```
- [ ] Restart SSH service
  ```bash
  sudo systemctl restart ssh
  ```

### Network Configuration
- [ ] Disable IPv6 if not needed
  ```bash
  sudo nano /etc/sysctl.conf
  # Add:
  # net.ipv6.conf.all.disable_ipv6 = 1
  # net.ipv6.conf.default.disable_ipv6 = 1
  # net.ipv6.conf.lo.disable_ipv6 = 1
  
  sudo sysctl -p
  ```
- [ ] Disable IP forwarding if not a router
  ```bash
  sudo nano /etc/sysctl.conf
  # Add: net.ipv4.ip_forward = 0
  
  sudo sysctl -p
  ```
- [ ] Harden TCP/IP stack
  ```bash
  sudo nano /etc/sysctl.conf
  # Add:
  # net.ipv4.conf.all.accept_redirects = 0
  # net.ipv4.conf.all.accept_source_route = 0
  # net.ipv4.conf.all.log_martians = 1
  # net.ipv4.conf.all.rp_filter = 1
  # net.ipv4.conf.all.send_redirects = 0
  # net.ipv4.icmp_echo_ignore_broadcasts = 1
  
  sudo sysctl -p
  ```

### Scheduled Tasks
- [ ] Review cron jobs (all users)
  ```bash
  for user in $(cut -f1 -d: /etc/passwd); do sudo crontab -u $user -l 2>/dev/null; done
  ```
- [ ] Check system-wide cron directories
  ```bash
  ls -la /etc/cron*
  ```
- [ ] Check user crontabs
  ```bash
  ls -la /var/spool/cron/crontabs/
  ```

## Software Security

### Updates
- [ ] Update package lists
  ```bash
  sudo apt update
  ```
- [ ] Install all available updates
  ```bash
  sudo apt upgrade -y
  ```
- [ ] Install security updates only (alternative)
  ```bash
  sudo apt-get dist-upgrade -y
  ```
- [ ] Configure automatic updates
  ```bash
  sudo apt install unattended-upgrades
  sudo dpkg-reconfigure -plow unattended-upgrades
  ```

### Package Verification
- [ ] Verify installed packages
  ```bash
  sudo apt install debsums
  sudo debsums -c
  ```
- [ ] Search for potentially compromised packages
  ```bash
  sudo apt-get --reinstall install <package-name>
  ```

## Logging and Auditing

### System Logging
- [ ] Ensure rsyslog is running
  ```bash
  sudo systemctl status rsyslog
  ```
- [ ] Configure log rotation
  ```bash
  sudo nano /etc/logrotate.conf
  ```
- [ ] Secure log files
  ```bash
  sudo chmod 640 /var/log/syslog
  sudo chmod 640 /var/log/auth.log
  ```
- [ ] Check log files for suspicious activities
  ```bash
  sudo grep -i "failed password" /var/log/auth.log
  ```

### Audit Framework
- [ ] Install auditd
  ```bash
  sudo apt install auditd
  ```
- [ ] Enable auditd service
  ```bash
  sudo systemctl enable auditd
  sudo systemctl start auditd
  ```
- [ ] Configure basic audit rules
  ```bash
  sudo nano /etc/audit/rules.d/audit.rules
  # Add rules to monitor sensitive files and commands
  ```

## Application Security

### Web Server (if present)
- [ ] Secure Apache configuration
  ```bash
  sudo nano /etc/apache2/apache2.conf
  # Check for security directives
  ```
- [ ] Remove unnecessary Apache modules
  ```bash
  sudo a2dismod <module>
  ```
- [ ] Secure Nginx configuration (if used)
  ```bash
  sudo nano /etc/nginx/nginx.conf
  # Check for security directives
  ```

### Database Server (if present)
- [ ] Secure MySQL/MariaDB
  ```bash
  sudo mysql_secure_installation
  ```
- [ ] Check MySQL/MariaDB users and permissions
  ```bash
  sudo mysql -u root -p
  SELECT user, host FROM mysql.user;
  ```

## System Hardening

### AppArmor
- [ ] Ensure AppArmor is installed and enabled
  ```bash
  sudo apt install apparmor apparmor-utils
  sudo systemctl enable apparmor
  sudo systemctl start apparmor
  ```
- [ ] Check AppArmor status
  ```bash
  sudo aa-status
  ```
- [ ] Enforce AppArmor profiles
  ```bash
  sudo aa-enforce /etc/apparmor.d/*
  ```

### Boot Security
- [ ] Secure GRUB bootloader
  ```bash
  sudo nano /etc/grub.d/40_custom
  # Add password protection
  
  sudo update-grub
  ```
- [ ] Review /etc/fstab for secure mount options
  ```bash
  sudo nano /etc/fstab
  # Add noexec, nosuid, nodev where appropriate
  ```

## Common Ubuntu/Linux Mint Vulnerabilities

- [ ] Check for unauthorized repositories
  ```bash
  sudo cat /etc/apt/sources.list
  ls -la /etc/apt/sources.list.d/
  ```
- [ ] Check for unauthorized startup applications
  ```bash
  ls -la /etc/xdg/autostart/
  ls -la ~/.config/autostart/
  ```
- [ ] Check for backdoor users in /etc/passwd
- [ ] Verify sudoers configuration doesn't have NOPASSWD entries
- [ ] Check for unauthorized SSH keys
  ```bash
  for user in $(cut -f1 -d: /etc/passwd); do 
    if [ -d "/home/$user/.ssh" ]; then 
      ls -la /home/$user/.ssh/; 
    fi; 
  done
  ```

## CyberPatriot-Specific Checks

- [ ] Check for prohibited software (games, hacking tools, etc.)
  ```bash
  dpkg -l | grep -i game
  dpkg -l | grep -i torrent
  dpkg -l | grep -i nmap
  ```
- [ ] Look for "forensics questions" files
  ```bash
  find /home -name "*.txt" -o -name "README*" 2>/dev/null
  ```
- [ ] Check for unauthorized media files
  ```bash
  find /home -name "*.mp3" -o -name "*.mp4" -o -name "*.avi" 2>/dev/null
  ```
- [ ] Look for unauthorized user management
  ```bash
  grep -i "useradd\|userdel\|usermod" /var/log/auth.log
  ```

## Verification Commands

- `sudo cat /etc/shadow` - Check user password complexity (encrypted strings)
- `sudo systemctl list-units --type=service` - List all services
- `sudo ufw status` - Check firewall status
- `sudo netstat -tulnp` or `sudo ss -tulnp` - List open ports and services
- `sudo ps aux` - List running processes
- `ls -la /etc/apt/sources.list.d/` - Check custom repositories
- `cat /var/log/auth.log | grep -i "fail"` - Check for failed logins
