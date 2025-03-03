# Advanced Linux Security for Ubuntu and Linux Mint

This advanced guide covers sophisticated security techniques for Ubuntu and Linux Mint systems. These advanced security implementations can help you secure systems against complex threats and earn maximum points in CyberPatriot competitions.

## Table of Contents

- [Mandatory Access Control](#mandatory-access-control)
- [Advanced File System Security](#advanced-file-system-security)
- [Intrusion Detection](#intrusion-detection)
- [Advanced Auditing and Monitoring](#advanced-auditing-and-monitoring)
- [Secure Authentication Mechanisms](#secure-authentication-mechanisms)
- [Advanced Network Security](#advanced-network-security)
- [Memory Protection Features](#memory-protection-features)
- [Security Automation and Orchestration](#security-automation-and-orchestration)
- [Threat Hunting Techniques](#threat-hunting-techniques)
- [Advanced CyberPatriot Techniques](#advanced-cyberpatriot-techniques)

## Mandatory Access Control

### AppArmor Profiles

AppArmor is Ubuntu and Linux Mint's default Mandatory Access Control (MAC) system.

#### Creating Custom AppArmor Profiles

1. Install necessary tools:
   ```bash
   sudo apt install apparmor-utils apparmor-profiles apparmor-profiles-extra
   ```

2. Create a profile for an application in learning mode:
   ```bash
   sudo aa-genprof /path/to/application
   ```

3. Run the application to capture activity, then finalize the profile:
   ```bash
   sudo aa-logprof
   ```

4. Put the profile in enforce mode:
   ```bash
   sudo aa-enforce /etc/apparmor.d/path.to.application
   ```

#### Auditing and Managing AppArmor

1. Check AppArmor status:
   ```bash
   sudo aa-status
   ```

2. List profiles and their modes:
   ```bash
   sudo apparmor_status
   ```

3. Find AppArmor log entries:
   ```bash
   sudo grep "apparmor" /var/log/syslog
   sudo grep "apparmor" /var/log/kern.log
   ```

#### Fine-tuning AppArmor Profiles

For a service like nginx, you can create highly restrictive profiles:

1. Edit the profile:
   ```bash
   sudo nano /etc/apparmor.d/usr.sbin.nginx
   ```

2. Example of a strict profile section:
   ```
   /usr/sbin/nginx {
     # Include base abstraction
     #include <abstractions/base>
     #include <abstractions/nameservice>
     #include <abstractions/openssl>
   
     # Binary capabilities
     capability net_bind_service,
     capability setgid,
     capability setuid,
   
     # Only allow read access to configuration
     /etc/nginx/** r,
   
     # Allow limited write access only to specific directories
     /var/log/nginx/*.log w,
     /var/lib/nginx/** rw,
     /run/nginx.pid rw,
   
     # Deny write access everywhere else
     deny /etc/nginx/** w,
     deny /etc/** w,
     deny /var/** w,
   }
   ```

3. Reload the profile:
   ```bash
   sudo apparmor_parser -r /etc/apparmor.d/usr.sbin.nginx
   ```

## Advanced File System Security

### Access Control Lists (ACLs)

ACLs provide more granular permission control than standard permissions:

1. Install ACL utilities:
   ```bash
   sudo apt install acl
   ```

2. Check if your file system supports ACLs:
   ```bash
   sudo tune2fs -l /dev/sdXY | grep "Default mount options"
   # Look for "acl" in the output
   ```

3. Set an ACL for a specific user:
   ```bash
   # Give user john read and write permissions to a file
   sudo setfacl -m u:john:rw /path/to/file
   
   # Give group developers read permissions to a directory
   sudo setfacl -m g:developers:r /path/to/directory
   
   # Set default ACL for new files in a directory
   sudo setfacl -d -m u:john:rw /path/to/directory
   ```

4. View ACLs on a file:
   ```bash
   getfacl /path/to/file
   ```

5. Remove specific ACL:
   ```bash
   sudo setfacl -x u:john /path/to/file
   ```

6. Remove all ACLs:
   ```bash
   sudo setfacl -b /path/to/file
   ```

### Extended Attributes

Extended attributes store additional metadata about files:

```bash
# Install attr package
sudo apt install attr

# Set attribute
sudo setfattr -n user.description -v "Confidential document" /path/to/file

# List attributes
getfattr -d /path/to/file

# Get specific attribute
getfattr -n user.description /path/to/file

# Remove attribute
sudo setfattr -x user.description /path/to/file
```

### Immutable and Append-Only Attributes

Protect critical files from modification:

```bash
# Make a file immutable (cannot be modified, deleted, renamed, or linked)
sudo chattr +i /path/to/important/file

# Set append-only attribute (can only be appended to, good for logs)
sudo chattr +a /var/log/secure_log

# View attributes
lsattr /path/to/file

# Remove immutable attribute
sudo chattr -i /path/to/important/file
```

### Advanced Disk Encryption

#### Full Disk Encryption with LUKS

For encrypting partitions beyond the initial setup:

```bash
# Install utilities
sudo apt install cryptsetup

# Create encrypted partition
sudo cryptsetup luksFormat /dev/sdXY

# Open encrypted partition
sudo cryptsetup luksOpen /dev/sdXY secret_data

# Format the decrypted partition
sudo mkfs.ext4 /dev/mapper/secret_data

# Mount the partition
sudo mount /dev/mapper/secret_data /mnt/encrypted

# Add key file as alternative to password
sudo cryptsetup luksAddKey /dev/sdXY /path/to/keyfile

# Change encryption passphrase
sudo cryptsetup luksChangeKey /dev/sdXY
```

#### Encrypted Home Directory

For securing individual user data:

```bash
# Install ecryptfs
sudo apt install ecryptfs-utils

# Migrate user's home to encrypted format
sudo ecryptfs-migrate-home -u username
```

## Intrusion Detection

### Host-based Intrusion Detection with AIDE

Advanced Intrusion Detection Environment (AIDE) checks file integrity:

1. Install AIDE:
   ```bash
   sudo apt install aide
   ```

2. Configure AIDE by editing `/etc/aide/aide.conf`:
   ```bash
   sudo nano /etc/aide/aide.conf
   ```

3. Customize rules. Example:
   ```
   # Monitor these directories with specific options
   /etc PERMS
   /bin NORMAL
   /sbin NORMAL
   /usr/bin NORMAL
   /usr/sbin NORMAL
   
   # Ignore these patterns
   !/var/log/.*
   !/var/spool/.*
   !/var/adm/utmp
   ```

4. Initialize the database:
   ```bash
   sudo aideinit
   ```

5. Move the initialized database:
   ```bash
   sudo mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
   ```

6. Run a check:
   ```bash
   sudo aide --check
   ```

7. Set up a daily cron job:
   ```bash
   sudo nano /etc/cron.daily/aide
   ```

   Add:
   ```bash
   #!/bin/bash
   /usr/bin/aide --check | mail -s "AIDE report for $(hostname)" root@localhost
   ```

   Make executable:
   ```bash
   sudo chmod +x /etc/cron.daily/aide
   ```

### Tripwire File Integrity Monitoring

Tripwire is another powerful file integrity monitoring tool:

1. Install Tripwire:
   ```bash
   sudo apt install tripwire
   ```

2. Initialize Tripwire (follow the prompts):
   ```bash
   sudo tripwire --init
   ```

3. Run an integrity check:
   ```bash
   sudo tripwire --check
   ```

4. Update policy if needed:
   ```bash
   sudo twadmin --create-polfile /etc/tripwire/twpol.txt
   sudo tripwire --init
   ```

### Rootkit Detection with Chkrootkit and Rkhunter

Use multiple tools for better detection:

```bash
# Update and run Chkrootkit
sudo apt update
sudo apt install chkrootkit
sudo chkrootkit

# Update and run Rkhunter
sudo apt install rkhunter
sudo rkhunter --update
sudo rkhunter --check --sk
```

Schedule regular scans:
```bash
echo '0 3 * * * root /usr/sbin/chkrootkit' | sudo tee -a /etc/cron.d/chkrootkit
echo '0 4 * * * root /usr/bin/rkhunter --check --sk' | sudo tee -a /etc/cron.d/rkhunter
```

## Advanced Auditing and Monitoring

### Advanced Auditd Configuration

The Linux Audit system can be finely tuned:

1. Create a comprehensive audit policy:
   ```bash
   sudo nano /etc/audit/rules.d/audit.rules
   ```

2. Add these advanced rules:
   ```
   # Monitor file access attempts that fail
   -a always,exit -F arch=b64 -S open,creat,truncate,ftruncate,openat -F exit=-EACCES -F key=access
   -a always,exit -F arch=b32 -S open,creat,truncate,ftruncate,openat -F exit=-EACCES -F key=access
   
   # Monitor changes to authentication mechanisms
   -w /etc/pam.d/ -p wa -k auth
   -w /etc/nsswitch.conf -p wa -k auth
   -w /etc/ssh/sshd_config -p wa -k auth
   
   # Watch for changes to system time
   -a always,exit -F arch=b64 -S adjtimex,settimeofday,clock_settime -F key=time-change
   -a always,exit -F arch=b32 -S adjtimex,settimeofday,clock_settime -F key=time-change
   
   # Monitor privileged command execution
   -a always,exit -F path=/usr/bin/sudo -F perm=x -F key=privileged
   -a always,exit -F path=/usr/bin/su -F perm=x -F key=privileged
   -a always,exit -F path=/usr/bin/passwd -F perm=x -F key=privileged
   
   # Monitor creation and mounting
   -a always,exit -F arch=b64 -S mount,umount2,mknod,mknodat -F key=mount
   -a always,exit -F arch=b32 -S mount,umount2,mknod,mknodat -F key=mount
   
   # Monitor modifications to the PAM configuration
   -w /etc/pam.d/ -p wa -k pam
   
   # Monitor kernel module operations
   -w /sbin/insmod -p x -k modules
   -w /sbin/rmmod -p x -k modules
   -w /sbin/modprobe -p x -k modules
   -a always,exit -F arch=b64 -S init_module,delete_module -F key=modules
   
   # Monitor unsuccessful unauthorized access attempts to files
   -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F key=access
   -a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F key=access
   -a always,exit -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F key=access
   -a always,exit -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F key=access
   ```

3. Reload audit rules:
   ```bash
   sudo systemctl restart auditd
   ```

4. Create an audit search script:
   ```bash
   sudo nano /usr/local/bin/audit-search
   ```

   Add:
   ```bash
   #!/bin/bash
   # Simple audit search utility
   
   if [ $# -lt 1 ]; then
       echo "Usage: $0 [search_term]"
       exit 1
   fi
   
   sudo ausearch -i -k "$1"
   ```

   Make executable:
   ```bash
   sudo chmod +x /usr/local/bin/audit-search
   ```

5. Use the script:
   ```bash
   audit-search access
   audit-search auth
   audit-search privileged
   ```

### Advanced Log Monitoring with Syslog-ng

For more sophisticated logging:

1. Install syslog-ng:
   ```bash
   sudo apt install syslog-ng
   ```

2. Create custom filter:
   ```bash
   sudo nano /etc/syslog-ng/conf.d/security.conf
   ```

   Add:
   ```
   # Define a security filter
   filter f_security { 
     facility(auth, authpriv) or
     (facility(daemon) and program("sshd")) or
     (facility(kern) and level(warn..emerg)) or
     (program("sudo")) or
     (program("fail2ban"));
   };
   
   # Define a separate log file
   destination security_log { file("/var/log/security.log"); };
   
   # Tie them together
   log { source(s_src); filter(f_security); destination(security_log); };
   ```

3. Restart syslog-ng:
   ```bash
   sudo systemctl restart syslog-ng
   ```

4. Create a log rotation policy:
   ```bash
   sudo nano /etc/logrotate.d/security
   ```

   Add:
   ```
   /var/log/security.log {
     rotate 30
     daily
     compress
     delaycompress
     missingok
     notifempty
     create 0640 syslog adm
     sharedscripts
     postrotate
       /usr/lib/rsyslog/rsyslog-rotate
     endscript
   }
   ```

### Log Analysis with Logwatch

Customize Logwatch for better security alerting:

1. Create custom configuration:
   ```bash
   sudo mkdir -p /etc/logwatch/conf/logfiles
   sudo mkdir -p /etc/logwatch/conf/services
   ```

2. Configure custom service:
   ```bash
   sudo nano /etc/logwatch/conf/services/secure-logins.conf
   ```

   Add:
   ```
   Title = "Security Logins"
   LogFile = secure
   *OnlyService = sshd
   *RemoveHeaders = 
   ```

3. Create script:
   ```bash
   sudo nano /etc/logwatch/scripts/services/secure-logins
   ```

   Add a custom script to analyze the logs and run logwatch:
   ```bash
   sudo logwatch --service secure-logins --range today --format html --output mail --mailto admin@example.com
   ```

## Secure Authentication Mechanisms

### Multi-factor Authentication

#### Google Authenticator PAM

Enable two-factor authentication for SSH and sudo:

1. Install Google Authenticator PAM module:
   ```bash
   sudo apt install libpam-google-authenticator
   ```

2. Configure for the current user:
   ```bash
   google-authenticator
   ```
   Follow the prompts and save the QR code or secret key.

3. Configure PAM for SSH:
   ```bash
   sudo nano /etc/pam.d/sshd
   ```

   Add:
   ```
   auth required pam_google_authenticator.so
   ```

4. Configure SSH to use the challenge-response:
   ```bash
   sudo nano /etc/ssh/sshd_config
   ```

   Set:
   ```
   ChallengeResponseAuthentication yes
   ```

5. Restart SSH:
   ```bash
   sudo systemctl restart ssh
   ```

6. Configure sudo to use 2FA (optional):
   ```bash
   sudo nano /etc/pam.d/sudo
   ```

   Add:
   ```
   auth required pam_google_authenticator.so
   ```

#### YubiKey Authentication

For hardware-based authentication:

1. Install required packages:
   ```bash
   sudo apt install libpam-u2f
   ```

2. Register YubiKey:
   ```bash
   mkdir -p ~/.config/Yubico
   pamu2fcfg > ~/.config/Yubico/u2f_keys
   ```

3. Configure PAM for login:
   ```bash
   sudo nano /etc/pam.d/login
   ```

   Add:
   ```
   auth required pam_u2f.so
   ```

### Password Quality and Aging

Create advanced password policy:

1. Install password quality packages:
   ```bash
   sudo apt install libpam-pwquality libpam-cracklib
   ```

2. Configure PAM for password quality:
   ```bash
   sudo nano /etc/pam.d/common-password
   ```

   Find and modify the line with `pam_pwquality.so`:
   ```
   password requisite pam_pwquality.so retry=3 minlen=15 difok=3 ucredit=-2 lcredit=-2 dcredit=-2 ocredit=-2 reject_username enforce_for_root dictcheck=1 maxrepeat=2 gecoscheck=1
   ```

   Options meaning:
   - `minlen=15`: Minimum password length
   - `difok=3`: Number of characters that must be different from previous password
   - `ucredit=-2`: Must have at least 2 uppercase letters
   - `lcredit=-2`: Must have at least 2 lowercase letters
   - `dcredit=-2`: Must have at least 2 digits
   - `ocredit=-2`: Must have at least 2 special characters
   - `reject_username`: Reject passwords containing the username
   - `dictcheck=1`: Check against dictionary words
   - `maxrepeat=2`: Maximum of 2 identical consecutive characters
   - `gecoscheck=1`: Check against GECOS field

3. Configure password aging with extreme restrictions:
   ```bash
   sudo nano /etc/login.defs
   ```

   Set:
   ```
   PASS_MAX_DAYS   45   # Maximum password age
   PASS_MIN_DAYS   7    # Minimum days between password changes
   PASS_WARN_AGE   7    # Days warning before password expires
   ```

4. Apply to existing accounts:
   ```bash
   for user in $(cut -d: -f1 /etc/passwd); do
     if [ $user != "root" ]; then
       sudo chage -M 45 -m 7 -W 7 $user
     fi
   done
   ```

### Account Lockout Policies

Configure advanced lockout policies:

1. Edit PAM configuration:
   ```bash
   sudo nano /etc/pam.d/common-auth
   ```

2. Add or modify the line with `pam_tally2.so`:
   ```
   auth required pam_tally2.so deny=5 unlock_time=1800 even_deny_root root_unlock_time=900
   ```

3. Check locked accounts:
   ```bash
   sudo pam_tally2
   ```

4. Unlock account:
   ```bash
   sudo pam_tally2 --user username --reset
   ```

## Advanced Network Security

### Advanced Firewall Configuration

#### Advanced UFW Rules

Create sophisticated UFW rules:

```bash
# Rate limiting for SSH (limit to 6 connections per 30 seconds)
sudo ufw limit proto tcp from any to any port 22 comment 'Rate limit SSH'

# Allow traffic only from specific IP ranges
sudo ufw allow from 192.168.1.0/24 to any port 22 comment 'Allow SSH from internal network'

# Deny outbound connections to specific ports
sudo ufw deny out to any port 25 comment 'Block outbound SMTP'

# Custom application rules (example for a web server)
sudo ufw allow proto tcp from any to any port 80,443 app "Nginx Full"

# Log all denied packets
sudo ufw logging on
sudo ufw logging high
```

#### Advanced iptables Configuration

For more complex firewall needs:

```bash
# Save this as /etc/iptables/advanced-rules.sh
#!/bin/bash

# Flush existing rules and set defaults
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Set default policies
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Allow loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Allow established and related connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# SSH with rate limiting (3 connections per minute)
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -j ACCEPT

# HTTP and HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Block specific IPs
iptables -A INPUT -s 192.168.1.100 -j DROP

# Log and drop all other traffic
iptables -A INPUT -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A INPUT -j DROP

# Save rules
iptables-save > /etc/iptables/rules.v4
```

Make it executable and run:
```bash
sudo chmod +x /etc/iptables/advanced-rules.sh
sudo /etc/iptables/advanced-rules.sh
```

Install iptables-persistent to make rules survive reboots:
```bash
sudo apt install iptables-persistent
sudo netfilter-persistent save
```

### Intrusion Prevention with Fail2ban

Create custom Fail2ban jails:

1. Create a custom filter:
   ```bash
   sudo nano /etc/fail2ban/filter.d/http-auth-failure.conf
   ```

   Add:
   ```
   [Definition]
   failregex = ^<HOST> - .* "GET .* HTTP/1\.[01]" 401 .*$
   ignoreregex =
   ```

2. Configure the jail:
   ```bash
   sudo nano /etc/fail2ban/jail.local
   ```

   Add:
   ```
   [http-auth]
   enabled = true
   port = http,https
   filter = http-auth-failure
   logpath = /var/log/apache2/access.log
   maxretry = 3
   bantime = 3600
   ```

3. Restart Fail2ban:
   ```bash
   sudo systemctl restart fail2ban
   ```

4. Monitor ban activity:
   ```bash
   sudo fail2ban-client status
   sudo fail2ban-client status http-auth
   ```

### Port Knocking

Implement port knocking for hidden services:

1. Install knockd:
   ```bash
   sudo apt install knockd
   ```

2. Configure knockd:
   ```bash
   sudo nano /etc/knockd.conf
   ```

   Add:
   ```
   [options]
   logfile = /var/log/knockd.log

   [openSSH]
   sequence    = 7000,8000,9000
   seq_timeout = 5
   command     = /sbin/iptables -A INPUT -s %IP% -p tcp --dport 22 -j ACCEPT
   tcpflags    = syn
   
   [closeSSH]
   sequence    = 9000,8000,7000
   seq_timeout = 5
   command     = /sbin/iptables -D INPUT -s %IP% -p tcp --dport 22 -j ACCEPT
   tcpflags    = syn
   ```

3. Edit knockd defaults:
   ```bash
   sudo nano /etc/default/knockd
   ```

   Set:
   ```
   START_KNOCKD=1
   KNOCKD_OPTS="-i eth0"  # Adjust interface as needed
   ```

4. Start knockd:
   ```bash
   sudo systemctl enable knockd
   sudo systemctl start knockd
   ```

5. From a client, knock on the ports:
   ```bash
   for port in 7000 8000 9000; do nmap -Pn --host-timeout 201 --max-retries 0 -p $port server_ip; done
   ```

### DNS Security

Enhance DNS security:

1. Install DNSSEC validation with systemd-resolved:
   ```bash
   sudo apt install systemd-resolved
   ```

2. Configure DNS over TLS:
   ```bash
   sudo nano /etc/systemd/resolved.conf
   ```

   Add:
   ```
   [Resolve]
   DNS=1.1.1.1 9.9.9.9
   DNSOverTLS=yes
   ```

3. Restart systemd-resolved:
   ```bash
   sudo systemctl restart systemd-resolved
   ```

4. Block unauthorized outbound DNS to prevent data exfiltration:
   ```bash
   sudo iptables -A OUTPUT -p udp --dport 53 -d 1.1.1.1 -j ACCEPT
   sudo iptables -A OUTPUT -p udp --dport 53 -d 9.9.9.9 -j ACCEPT
   sudo iptables -A OUTPUT -p udp --dport 53 -j DROP
   ```

## Memory Protection Features

### Address Space Layout Randomization (ASLR)

Enable system-wide ASLR:

```bash
# Check current status
cat /proc/sys/kernel/randomize_va_space

# Enable maximum ASLR (value 2)
echo 2 | sudo tee /proc/sys/kernel/randomize_va_space

# Make it permanent
echo "kernel.randomize_va_space = 2" | sudo tee -a /etc/sysctl.d/99-security.conf
sudo sysctl -p /etc/sysctl.d/99-security.conf
```

### Kernel Protection Features

Enable kernel security features:

1. Edit sysctl configuration:
   ```bash
   sudo nano /etc/sysctl.d/99-kernel-hardening.conf
   ```

2. Add kernel hardening parameters:
   ```
   # Protect against certain kernel exploits
   kernel.kptr_restrict=2
   kernel.dmesg_restrict=1
   
   # Protect against memory vulnerabilities
   vm.mmap_min_addr=65536
   
   # Disable magic SysRq keys except safe ones
   kernel.sysrq=4
   
   # Improve file system security
   fs.protected_hardlinks=1
   fs.protected_symlinks=1
   
   # Increase pid_max to prevent pid reuse attacks
   kernel.pid_max=65536
   
   # Disable unprivileged user namespaces
   kernel.unprivileged_userns_clone=0
   
   # Restrict ptrace scope
   kernel.yama.ptrace_scope=1
   ```

3. Apply settings:
   ```bash
   sudo sysctl -p /etc/sysctl.d/99-kernel-hardening.conf
   ```

## Security Automation and Orchestration

### Advanced Security Scripts

Create a comprehensive security audit script:

```bash
#!/bin/bash
# Advanced Security Audit Script
# Save as /usr/local/bin/security-audit.sh

LOG_FILE="/var/log/security-audit-$(date +%F).log"

echo "=== Security Audit Report for $(hostname) ===" | tee -a "$LOG_FILE"
echo "Generated on: $(date)" | tee -a "$LOG_FILE"
echo "============================================" | tee -a "$LOG_FILE"

# Check users with UID 0
echo -e "\n>>> Users with UID 0 (should only be root):" | tee -a "$LOG_FILE"
awk -F: '$3 == 0 {print $1}' /etc/passwd | tee -a "$LOG_FILE"

# Check users with empty passwords
echo -e "\n>>> Users with empty passwords:" | tee -a "$LOG_FILE"
awk -F: '($2 == "" || $2 == "*" || $2 == "!") {print $1}' /etc/shadow | tee -a "$LOG_FILE"

# Check sudo access
echo -e "\n>>> Users with sudo access:" | tee -a "$LOG_FILE"
grep -Po '^sudo:.*:\K.*$' /etc/group | tee -a "$LOG_FILE"

# Check for unusual SUID/SGID files
echo -e "\n>>> Unusual SUID/SGID files:" | tee -a "$LOG_FILE"
find / -type f \( -perm -4000 -o -perm -2000 \) -not -path "/usr/bin/*" -not -path "/bin/*" -not -path "/sbin/*" -not -path "/usr/sbin/*" -not -path "/usr/local/bin/*" -not -path "/usr/local/sbin/*" 2>/dev/null | tee -a "$LOG_FILE"

# Check for open ports
echo -e "\n>>> Listening ports:" | tee -a "$LOG_FILE"
ss -tulpn | tee -a "$LOG_FILE"

# Check for unauthorized SSH keys
echo -e "\n>>> Checking for SSH authorized keys:" | tee -a "$LOG_FILE"
for DIR in /home/*/.ssh /root/.ssh; do
  if [ -d "$DIR" ]; then
    if [ -f "$DIR/authorized_keys" ]; then
      echo "Keys found in $DIR/authorized_keys:" | tee -a "$LOG_FILE"
      cat "$DIR/authorized_keys" | tee -a "$LOG_FILE"
    fi
  fi
done

# Check for suspicious cron jobs
echo -e "\n>>> Unusual cron jobs:" | tee -a "$LOG_FILE"
find /etc/cron* -type f | xargs cat | grep -v "^#" | tee -a "$LOG_FILE"
find /var/spool/cron/crontabs -type f | xargs cat | grep -v "^#" | tee -a "$LOG_FILE"

# Check for world-writable files
echo -e "\n>>> World-writable files in /etc:" | tee -a "$LOG_FILE"
find /etc -type f -perm -o+w 2>/dev/null | tee -a "$LOG_FILE"

# Check AppArmor status
echo -e "\n>>> AppArmor status:" | tee -a "$LOG_FILE"
aa-status | tee -a "$LOG_FILE"

# Check firewall
echo -e "\n>>> Firewall status:" | tee -a "$LOG_FILE"
ufw status verbose | tee -a "$LOG_FILE"

# Check for unusual processes
echo -e "\n>>> Processes running as root:" | tee -a "$LOG_FILE"
ps aux | grep root | tee -a "$LOG_FILE"

# Check loaded kernel modules
echo -e "\n>>> Loaded kernel modules:" | tee -a "$LOG_FILE"
lsmod | tee -a "$LOG_FILE"

echo -e "\n>>> Security audit completed. Report saved to $LOG_FILE" | tee -a "$LOG_FILE"
```

Make the script executable and run periodically:
```bash
sudo chmod +x /usr/local/bin/security-audit.sh
echo "0 4 * * * root /usr/local/bin/security-audit.sh" | sudo tee /etc/cron.d/security-audit
```

### Using Ansible for Security Compliance

Automate security hardening with Ansible:

1. Install Ansible:
   ```bash
   sudo apt install ansible
   ```

2. Create a security playbook:
   ```bash
   mkdir -p ~/ansible/security
   cd ~/ansible/security
   nano security-hardening.yml
   ```

3. Add playbook content:
   ```yaml
   ---
   - name: Linux Security Hardening
     hosts: localhost
     become: yes
     
     tasks:
       - name: Update all packages
         apt:
           update_cache: yes
           upgrade: dist
       
       - name: Install security packages
         apt:
           name:
             - ufw
             - fail2ban
             - apparmor
             - apparmor-utils
             - auditd
             - aide
             - rkhunter
             - lynis
           state: present
       
       - name: Enable UFW
         ufw:
           state: enabled
           policy: deny
           direction: incoming
       
       - name: Allow SSH
         ufw:
           rule: allow
           port: '22'
       
       - name: Set secure permissions on sensitive files
         file:
           path: "{{ item }}"
           mode: '0600'
           owner: root
           group: root
         loop:
           - /etc/shadow
           - /etc/gshadow
       
       - name: Set secure permissions on passwd and group
         file:
           path: "{{ item }}"
           mode: '0644'
           owner: root
           group: root
         loop:
           - /etc/passwd
           - /etc/group
       
       - name: Configure sysctl settings
         sysctl:
           name: "{{ item.name }}"
           value: "{{ item.value }}"
           state: present
           reload: yes
         loop:
           - { name: 'kernel.kptr_restrict', value: '2' }
           - { name: 'kernel.dmesg_restrict', value: '1' }
           - { name: 'net.ipv4.conf.all.rp_filter', value: '1' }
           - { name: 'net.ipv4.conf.default.rp_filter', value: '1' }
           - { name: 'net.ipv4.conf.all.accept_redirects', value: '0' }
           - { name: 'net.ipv4.conf.default.accept_redirects', value: '0' }
       
       - name: Configure SSH server
         lineinfile:
           path: /etc/ssh/sshd_config
           regexp: "{{ item.regexp }}"
           line: "{{ item.line }}"
           state: present
         loop:
           - { regexp: '^PermitRootLogin', line: 'PermitRootLogin no' }
           - { regexp: '^X11Forwarding', line: 'X11Forwarding no' }
           - { regexp: '^Protocol', line: 'Protocol 2' }
           - { regexp: '^MaxAuthTries', line: 'MaxAuthTries 3' }
           - { regexp: '^PermitEmptyPasswords', line: 'PermitEmptyPasswords no' }
         notify:
           - restart sshd
     
     handlers:
       - name: restart sshd
         service:
           name: sshd
           state: restarted
   ```

4. Run the playbook:
   ```bash
   ansible-playbook -i localhost, -c local security-hardening.yml
   ```

## Threat Hunting Techniques

### Memory Forensics

Analyzing memory for malware and suspicious activity:

1. Install Volatility prerequisites:
   ```bash
   sudo apt install git python3-pip python3-dev libpython3-dev
   ```

2. Clone Volatility and prepare for use:
   ```bash
   git clone https://github.com/volatilityfoundation/volatility3.git
   cd volatility3
   pip3 install -r requirements.txt
   python3 setup.py install
   ```

3. Create memory dump with LiME (Linux Memory Extractor):
   ```bash
   sudo apt install linux-headers-$(uname -r) build-essential
   git clone https://github.com/504ensicsLabs/LiME.git
   cd LiME/src
   make
   sudo insmod lime-$(uname -r).ko "path=/tmp/memory.lime format=lime"
   ```

4. Analyze memory dump with Volatility:
   ```bash
   # List available plugins
   python3 vol.py -f /tmp/memory.lime linux.info
   
   # Check running processes
   python3 vol.py -f /tmp/memory.lime linux.pslist
   
   # Check network connections
   python3 vol.py -f /tmp/memory.lime linux.netstat
   
   # Check loaded kernel modules
   python3 vol.py -f /tmp/memory.lime linux.lsmod
   ```

### Advanced Malware Detection

Finding sophisticated malware:

```bash
# Search for files created/modified in the last 24 hours
find / -type f -mtime -1 -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" 2>/dev/null

# Find files with unusual permissions
find / -type f -perm -4000 -o -perm -2000 2>/dev/null

# Find hidden files and directories
find / -name ".*" -type f -not -path "*/\.*" 2>/dev/null
find / -name ".*" -type d -not -path "*/\.*" 2>/dev/null

# Examine unusual network connections
netstat -tlpn
lsof -i

# Check crontab entries for all users
for user in $(cut -f1 -d: /etc/passwd); do echo $user; crontab -u $user -l 2>/dev/null; done

# Look for unusual SUID/SGID files
find / -type f -perm -4000 -o -perm -2000 -ls 2>/dev/null | sort -k 3
```

### Identifying Persistence Mechanisms

Checking for backdoors and persistent access:

```bash
# Check for unusual systemd services
systemctl list-unit-files --type=service | grep enabled
find /etc/systemd/system -type f | xargs cat | grep -i "ExecStart"

# Check startup scripts
find /etc/init.d -type f | xargs cat | grep -v "^#"

# Check common backdoor locations
find /dev/shm -type f -exec ls -la {} \;
find /tmp -type f -exec ls -la {} \;
find /var/tmp -type f -exec ls -la {} \;

# Check for unusual PAM modules
find /lib/*/security -name "*.so" | sort

# Check SSH authorized keys
find /home -name "authorized_keys" -exec cat {} \;
cat /root/.ssh/authorized_keys 2>/dev/null

# Check for unusual shell history
for user in $(ls /home); do 
  cat /home/$user/.bash_history 2>/dev/null | grep -E "wget|curl|nc|netcat|bash.*\\-i" 
done
```

## Advanced CyberPatriot Techniques

### Detecting Competition Artifacts

During CyberPatriot competitions, look for specific artifacts:

```bash
# Find files with specific names (often used in CyberPatriot)
find / -name "*flag*" -type f 2>/dev/null
find / -name "*readme*" -type f 2>/dev/null
find / -name "*score*" -type f 2>/dev/null
find / -name "*points*" -type f 2>/dev/null
find / -name "*.jpg" -o -name "*.png" -o -name "*.mp3" 2>/dev/null

# Look for recently created files
find / -type f -cmin -60 2>/dev/null

# Check for files in unusual locations
find /var/www -type f -name "*.php" | xargs grep -l "shell_exec"
find /opt -type f -executable 2>/dev/null
```

### Creating Comprehensive System Reports

Generate detailed reports for competition documentation:

```bash
# Create a system report script
cat > system-report.sh << 'EOF'
#!/bin/bash
REPORT_FILE="system-report-$(hostname)-$(date +%F).txt"

echo "SYSTEM REPORT FOR $(hostname)" > $REPORT_FILE
echo "Generated on $(date)" >> $REPORT_FILE
echo "================================" >> $REPORT_FILE

echo -e "\n--- SYSTEM INFORMATION ---" >> $REPORT_FILE
uname -a >> $REPORT_FILE
lsb_release -a >> $REPORT_FILE 2>/dev/null

echo -e "\n--- DISK USAGE ---" >> $REPORT_FILE
df -h >> $REPORT_FILE

echo -e "\n--- USERS ---" >> $REPORT_FILE
echo "Regular users:" >> $REPORT_FILE
awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd >> $REPORT_FILE

echo -e "\nSystem users:" >> $REPORT_FILE
awk -F: '$3 > 0 && $3 < 1000 {print $1}' /etc/passwd >> $REPORT_FILE

echo -e "\nSudo users:" >> $REPORT_FILE
grep -Po '^sudo:.*:\K.*$' /etc/group >> $REPORT_FILE

echo -e "\n--- SERVICES ---" >> $REPORT_FILE
systemctl list-units --type=service --state=active >> $REPORT_FILE

echo -e "\n--- LISTENING PORTS ---" >> $REPORT_FILE
ss -tulpn >> $REPORT_FILE

echo -e "\n--- INSTALLED PACKAGES ---" >> $REPORT_FILE
dpkg -l | grep ^ii >> $REPORT_FILE

echo -e "\n--- FIREWALL STATUS ---" >> $REPORT_FILE
ufw status verbose >> $REPORT_FILE

echo -e "\nReport generated at $REPORT_FILE"
EOF

chmod +x system-report.sh
./system-report.sh
```

### Advanced Competition Strategies

For maximum points in CyberPatriot, follow these strategies:

1. **Prioritize by Point Value**:
   - Read the README file thoroughly to identify high-point items
   - Focus on user security, services, and updates first
   - Leave time-consuming, low-point tasks for later

2. **Methodical Approach**:
   - Use a checklist to ensure nothing is missed
   - Document all changes you make
   - Take periodic system snapshots if allowed

3. **Advanced Techniques**:
   - Look for hidden files in unusual locations
   - Check for cron jobs and startup scripts
   - Investigate all running processes
   - Scan for rootkits and backdoors

4. **Monitoring Score Engine**:
   - Regularly check the scoring report
   - Note which changes resulted in points
   - If a change causes lost points, restore from documentation

5. **Essential Checks**:
   ```bash
   # Essential security checks
   
   # 1. User security
   getent passwd
   getent group sudo
   getent shadow
   
   # 2. Service security
   systemctl list-units --type=service --state=active
   netstat -tulpn
   
   # 3. File security
   find / -perm -4000 -ls 2>/dev/null
   find / -perm -2000 -ls 2>/dev/null
   find / -type f -name ".*" -ls 2>/dev/null
   
   # 4. Network security
   ufw status verbose
   iptables -L -v
   
   # 5. System config
   cat /etc/sysctl.conf
   ls -la /etc/cron*
   ```

## Conclusion

This advanced guide covers sophisticated security techniques for Ubuntu and Linux Mint systems. By implementing these measures, you'll significantly improve your system's security posture and be well-prepared for higher-level CyberPatriot competitions.

Remember that security is a continuous process. Regularly audit your systems, stay informed about new vulnerabilities and threats, and update your security measures accordingly.

## Additional Resources

- [Ubuntu Security Documentation](https://ubuntu.com/security/certifications)
- [CIS Benchmarks for Ubuntu Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [NIST Special Publication 800-53](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [Linux Hardening Guide by NSA](https://apps.nsa.gov/iaarchive/library/ia-guidance/security-configuration/operating-systems/guide-to-the-secure-configuration-of-red-hat-enterprise.cfm)
- [OSSEC Documentation](https://www.ossec.net/docs/)
