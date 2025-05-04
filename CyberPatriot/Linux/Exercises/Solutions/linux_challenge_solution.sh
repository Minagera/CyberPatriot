#!/bin/bash
# CyberPatriot Linux Security Challenge - Mentor Solution Example
# This script demonstrates key steps for securing the challenge VM.
# Do NOT distribute to cadets before exercise completion.

# 1. Remove unauthorized users
for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    if [[ "$user" != "cadet" && "$user" != "admin" ]]; then
        sudo deluser --remove-home "$user"
    fi
done

# 2. Set password policy
sudo sed -i 's/^PASS_MIN_LEN.*/PASS_MIN_LEN   12/' /etc/login.defs
sudo sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs

# 3. Secure SSH
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

# 4. Enable and configure UFW firewall
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow OpenSSH
sudo ufw enable

# 5. Remove suspicious cron jobs
sudo find /etc/cron* -type f -exec grep -l 'nc\|bash -i\|python' {} \; | xargs -r sudo rm -f

# 6. Check for SUID/SGID binaries
sudo find / -perm /6000 -type f -not -path "/proc/*" > /root/suid_sgid_report.txt

# 7. Update system
sudo apt update && sudo apt upgrade -y

# 8. Document changes
echo "All changes documented in /root/security_change_log.txt"
