#!/bin/bash
# CyberPatriot Linux Incident Response Scenario - "Innovatech Dynamics Breach"
# Prepares a Linux VM with simulated compromise for CyberPatriot training.

set -e

# Create authorized users
useradd -m -s /bin/bash sysadmin
echo "sysadmin:Company2023!" | chpasswd

# Create backdoor user
useradd -m -s /bin/bash attacker1
echo "attacker1:password123" | chpasswd
usermod -aG sudo attacker1

# Install and misconfigure services
apt-get update
apt-get install -y openssh-server vsftpd apache2
sed -i 's/PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Add malicious cron job
echo "* * * * * root echo 'Hacked' > /tmp/hacked.txt" > /etc/cron.d/hacked

# Place scenario README on desktop
mkdir -p /home/sysadmin/Desktop
cat > /home/sysadmin/Desktop/README-Innovatech-Incident.txt <<EOF
Innovatech Dynamics Linux Breach Scenario

- Remove unauthorized users and cron jobs
- Harden SSH and services
- Secure the system per company policy
- Answer forensic questions in this file

Login: sysadmin / Company2023!
EOF

chown sysadmin:sysadmin /home/sysadmin/Desktop/README-Innovatech-Incident.txt

echo "Linux VM setup complete. Take a snapshot now for CyberPatriot training."
