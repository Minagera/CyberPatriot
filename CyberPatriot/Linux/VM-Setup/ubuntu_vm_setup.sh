#!/bin/bash
# CyberPatriot Ubuntu VM Setup Script (unique for training)

set -e

echo "[*] Setting hostname to 'cyberpatriot-ubuntu'"
hostnamectl set-hostname "cyberpatriot-ubuntu"

echo "[*] Creating user 'cadet' with secure password"
useradd -m -s /bin/bash cadet
echo "cadet:CyberP@tr10t!" | chpasswd
usermod -aG sudo cadet

echo "[*] Installing and enabling UFW"
apt-get update
apt-get install -y ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

echo "[*] Installing OpenSSH server"
apt-get install -y openssh-server
sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh

echo "[*] Creating world-writable file for scenario"
touch /etc/world_writable.txt
chmod 666 /etc/world_writable.txt

echo "[*] Setup complete. Take a VM snapshot now."
