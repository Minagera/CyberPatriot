#!/bin/bash
# CyberPatriot Linux VM Setup Script (Unique for Training)

# 1. Create a new user for practice
useradd -m -s /bin/bash cybercadet
echo "cybercadet:P@ssw0rd123" | chpasswd

# 2. Add user to sudo group
usermod -aG sudo cybercadet

# 3. Disable guest account (if applicable)
if grep -q "allow-guest" /etc/lightdm/lightdm.conf 2>/dev/null; then
  sed -i 's/allow-guest=true/allow-guest=false/' /etc/lightdm/lightdm.conf
else
  echo "[SeatDefaults]" >> /etc/lightdm/lightdm.conf
  echo "allow-guest=false" >> /etc/lightdm/lightdm.conf
fi

# 4. Enable UFW firewall and allow SSH
ufw enable
ufw allow ssh

# 5. Create a vulnerable service for practice
echo -e "[Unit]\nDescription=Vulnerable Service\n[Service]\nExecStart=/bin/sleep infinity\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/vulnservice.service
systemctl daemon-reload
systemctl enable vulnservice

echo "Linux VM setup for CyberPatriot training complete."
