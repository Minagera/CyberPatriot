#!/bin/bash
# SSH Hardening Script Template (for CyberPatriot)

SSHD_CONFIG="/etc/ssh/sshd_config"
cp "$SSHD_CONFIG" "$SSHD_CONFIG.bak"

sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' "$SSHD_CONFIG"
sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication yes/' "$SSHD_CONFIG"
sed -i 's/^#*X11Forwarding.*/X11Forwarding no/' "$SSHD_CONFIG"
echo "MaxAuthTries 3" >> "$SSHD_CONFIG"

systemctl restart ssh
echo "SSH configuration hardened."
