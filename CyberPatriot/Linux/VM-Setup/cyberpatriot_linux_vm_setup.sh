#!/bin/bash
# CyberPatriot Linux VM Setup Script - Unique Scenario Generator
# For instructor use only. Tested on Ubuntu 22.04 LTS.

set -e

# --- Customizable Variables ---
HOSTNAME="cyberpatriot-linux"
PRIMARY_USER="sysadmin"
PRIMARY_PASS="CyberP@tr1ot2024!"
AUTHORIZED_USERS=("sysadmin" "cadet1" "cadet2")
UNAUTHORIZED_USERS=("hacker" "guest" "testuser")
SSH_PORT=22

echo "[*] Setting hostname..."
sudo hostnamectl set-hostname "$HOSTNAME"

echo "[*] Creating authorized users..."
for user in "${AUTHORIZED_USERS[@]}"; do
    if ! id "$user" &>/dev/null; then
        sudo useradd -m -s /bin/bash "$user"
        echo "$user:$PRIMARY_PASS" | sudo chpasswd
        sudo usermod -aG sudo "$user"
    fi
done

echo "[*] Creating unauthorized users (for scenario)..."
for user in "${UNAUTHORIZED_USERS[@]}"; do
    sudo useradd -m -s /bin/bash "$user"
    echo "$user:WeakPass123" | sudo chpasswd
done

echo "[*] Installing and configuring SSH..."
sudo apt-get update
sudo apt-get install -y openssh-server
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo "[*] Installing and enabling UFW firewall..."
sudo apt-get install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow "$SSH_PORT"/tcp
sudo ufw enable

echo "[*] Installing scenario services (FTP, Telnet for removal)..."
sudo apt-get install -y vsftpd telnetd

echo "[*] Creating world-writable file for scenario..."
sudo touch /etc/world_writable.txt
sudo chmod 666 /etc/world_writable.txt

echo "[*] Adding suspicious cron job for scenario..."
echo "* * * * * root echo 'Hacked' > /tmp/hacked.txt" | sudo tee -a /etc/crontab

echo "[*] Installing outdated/vulnerable package for scenario..."
sudo apt-get install -y apache2=2.4.52-1ubuntu4

echo "[*] Creating README for cadets..."
cat <<EOF | sudo tee /home/$PRIMARY_USER/README-CyberPatriot-Scenario.txt
CyberPatriot Linux VM Scenario

- Harden user accounts and remove unauthorized users.
- Secure SSH and disable root login.
- Remove unnecessary and insecure services.
- Fix world-writable files.
- Remove suspicious cron jobs.
- Update all packages and remove obsolete software.
- Document all changes.

Login: $PRIMARY_USER / $PRIMARY_PASS
EOF

sudo chown "$PRIMARY_USER":"$PRIMARY_USER" /home/$PRIMARY_USER/README-CyberPatriot-Scenario.txt

echo "[*] Setup complete. Take a VM snapshot now for distribution."
