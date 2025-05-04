#!/bin/bash
# Firewall Setup Template Script for CyberPatriot

# Enable UFW and set default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH
sudo ufw allow ssh

# Allow HTTP (if needed)
# sudo ufw allow http

# Enable UFW
sudo ufw enable

# Show status
sudo ufw status verbose

echo "Firewall configuration complete."
