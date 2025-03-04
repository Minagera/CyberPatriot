# Linux Security Checklist for CyberPatriot

## CRITICAL FIRST STEP: Read the Competition README File!
Before making any changes, thoroughly read the README file provided with the competition image. It contains:
- Required services that must remain operational
- User accounts that must be maintained
- Prohibited actions that could cause penalties
- Answers to forensics questions (worth points!)
- Competition-specific requirements that override general security practices

This checklist covers essential security settings for Ubuntu and Linux Mint systems commonly tested in CyberPatriot competitions. Focus on these items to quickly secure your Linux system and gain points, but always follow README instructions when they conflict with general security practices.

## User Account Management

### Critical User Settings
- [ ] Change all user passwords to strong passwords
  ```bash
  sudo passwd username
  ```
- [ ] Remove unauthorized user accounts
  ```bash
  sudo userdel -r username
  ```
- [ ] Check for users with UID 0 (root privileges)
  ```bash
  sudo awk -F: '($3 == 0) {print}' /etc/passwd
  ```
- [ ] Check sudo access list
  ```bash
  sudo cat /etc/sudoers
  sudo ls /etc/sudoers.d/
  ```
- [ ] Remove unauthorized users from sudo group
  ```bash
  sudo deluser username sudo
  ```
- [ ] Disable user accounts that should not be active
  ```bash
  sudo passwd -l username
  ```

### Password Policy
- [ ] Install password quality checking library
  ```bash
  sudo apt install libpam-pwquality
  ```
- [ ] Configure basic password policy (minimum length, complexity)
  ```bash
  sudo nano /etc/pam.d/common-password
  # Add or modify this line:
  password requisite pam_pwquality.so retry=3 minlen=10 ucredit=-1 lcredit=-1 dcredit=-1
  ```
- [ ] Set password aging policy
  ```bash
  sudo nano /etc/login.defs
  # Change these values:
  PASS_MAX_DAYS 90
  PASS_MIN_DAYS 7
  PASS_WARN_AGE 14
  ```
- [ ] Apply password policy to existing users
  ```bash
  sudo chage -m 7 -M 90 -W 14 username
  ```

## System Security

### Firewall (UFW)
- [ ] Install UFW if not present
  ```bash
  sudo apt install ufw
  ```
- [ ] Enable UFW
  ```bash
  sudo ufw enable
  ```
- [ ] Set default policies
  ```bash
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  ```
- [ ] Allow needed services (ssh, http if needed)
  ```bash
  sudo ufw allow ssh
  ```
- [ ] Check firewall status
  ```bash
  sudo ufw status verbose
  ```

### Updates
- [ ] Update package lists
  ```bash
  sudo apt update
  ```
- [ ] Install system updates
  ```bash
  sudo apt upgrade -y
  ```
- [ ] Enable automatic security updates
  ```bash
  sudo apt install unattended-upgrades
  sudo dpkg-reconfigure -plow unattended-upgrades
  ```

### SSH Configuration
- [ ] Secure SSH server (if SSH is needed)
  ```bash
  sudo nano /etc/ssh/sshd_config
  ```
  
  Key settings to change:
  ```
  PermitRootLogin no
  PasswordAuthentication yes  # Unless using key authentication
  X11Forwarding no
  MaxAuthTries 3
  ```
- [ ] Restart SSH service after changes
  ```bash
  sudo systemctl restart ssh
  ```
- [ ] Disable SSH server if not needed
  ```bash
  sudo systemctl stop ssh
  sudo systemctl disable ssh
  ```

## Services and Applications

### Disable Unnecessary Services
- [ ] List all running services
  ```bash
  sudo systemctl list-units --type=service --state=active
  ```
- [ ] Disable unnecessary services (examples)
  ```bash
  sudo systemctl stop servicename
  sudo systemctl disable servicename
  ```
  
  Common services to check:
  - [ ] Telnet server
  - [ ] FTP server
  - [ ] Web server (if not needed)
  - [ ] Print server (if not needed)
  - [ ] Samba/Windows file sharing (if not needed)

### Remove Unauthorized Software
- [ ] Check for prohibited software
  ```bash
  # Look for games
  dpkg -l | grep -i game
  
  # Look for hacking tools
  dpkg -l | grep -i nmap
  dpkg -l | grep -i wireshark
  
  # Look for media software
  dpkg -l | grep -i media
  ```
- [ ] Remove unauthorized packages
  ```bash
  sudo apt purge packagename
  ```
- [ ] Clean up dependencies
  ```bash
  sudo apt autoremove
  ```

## File System Security

### Critical File Permissions
- [ ] Set correct permissions for critical files
  ```bash
  sudo chmod 644 /etc/passwd
  sudo chmod 640 /etc/shadow
  sudo chmod 644 /etc/group
  sudo chmod 640 /etc/gshadow
  ```
- [ ] Check for world-writable files (potential security issue)
  ```bash
  sudo find / -type f -perm -o+w -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" -exec ls -l {} \;
  ```
- [ ] Check for SUID/SGID files (potential security issue)
  ```bash
  sudo find / -type f -perm /6000 -ls
  ```

### Check for Unauthorized Files
- [ ] Search for media files in home directories
  ```bash
  sudo find /home -name "*.mp3" -o -name "*.mp4" -o -name "*.avi" 2>/dev/null
  ```
- [ ] Look for suspicious scripts
  ```bash
  sudo find /home -name "*.sh" 2>/dev/null
  ```

## Network Security

### Network Configuration
- [ ] Check for listening services/ports
  ```bash
  sudo ss -tulpn
  ```
- [ ] Check active network connections
  ```bash
  sudo netstat -ano
  ```

## Search for Forensics Questions

- [ ] Check for README files
  ```bash
  find /home -name "README*" 2>/dev/null
  find / -name "*.txt" -not -path "/proc/*" 2>/dev/null
  ```
- [ ] Check for files with "answer" in the name
  ```bash
  find / -name "*answer*" -not -path "/proc/*" 2>/dev/null
  ```
- [ ] Check common locations for competition files
  ```bash
  ls -la /home/*/Desktop
  ls -la /root/Desktop
  ls -la /home/*/Documents
  ```

## Common CyberPatriot Scoring Items

- [ ] Unauthorized users removed
- [ ] Strong passwords set for all accounts
- [ ] Root/sudo access properly restricted
- [ ] Password policies configured
- [ ] Updates installed
- [ ] Firewall enabled and configured
- [ ] SSH server secured or disabled
- [ ] Unnecessary services disabled
- [ ] Malware removed
- [ ] Unauthorized software removed
- [ ] Critical file permissions set properly
- [ ] Prohibited media files removed
- [ ] Finding and answering forensics questions

## Quick Status Check Commands

### User and Group Management
```bash
# List all users
cat /etc/passwd | cut -d: -f1,3,6

# List all sudo users
grep -Po '^sudo.+:\K.*$' /etc/group
cat /etc/sudoers

# List logged-in users
who
```

### Service Status
```bash
# Check running services
systemctl list-units --type=service --state=active

# Check service listening on network
ss -tulpn
```

### System Security Checks
```bash
# Check firewall status
sudo ufw status

# Check SSH configuration
grep -v '^#' /etc/ssh/sshd_config | grep -v '^$'

# Check for SUID binaries
find / -perm -4000 -type f -exec ls -la {} \; 2>/dev/null
```

### Package Management
```bash
# Check recently installed packages
grep -i installed /var/log/dpkg.log | tail -20

# Check for specific categories of software
dpkg -l | grep -i game
```
