#!/bin/bash
# CyberPatriot Linux VM Setup Script (Unique Example)
# Run as root

echo "Starting CyberPatriot Linux VM Setup..."

# Create standard user
useradd -m cadet1
echo "cadet1:Cadet!2024" | chpasswd

# Remove unauthorized users
for u in hacker testuser; do
    id "$u" &>/dev/null && userdel -r "$u"
done

# Set password policy
sed -i '/^PASS_MIN_LEN/c\PASS_MIN_LEN   10' /etc/login.defs
sed -i '/pam_pwquality.so/ s/$/ minlen=10 retry=3/' /etc/pam.d/common-password

# Enable UFW firewall
ufw --force enable
ufw default deny incoming
ufw allow ssh

# Update system
apt-get update && apt-get -y upgrade

echo "Linux VM setup complete. Please review all settings before competition."
