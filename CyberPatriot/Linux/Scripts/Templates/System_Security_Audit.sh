#!/bin/bash
# System Security Audit Script Template for CyberPatriot
# This script performs a broad security assessment of a Linux system.

echo "=== System Security Audit ==="

# User and group audit
echo "--- Users and Groups ---"
cat /etc/passwd
cat /etc/group

# Sudoers check
echo "--- Sudoers ---"
sudo cat /etc/sudoers
sudo ls /etc/sudoers.d/

# Running services
echo "--- Running Services ---"
systemctl list-units --type=service --state=active

# Open ports
echo "--- Open Ports ---"
sudo ss -tulpn

# World-writable files
echo "--- World-writable Files ---"
sudo find / -type f -perm -o+w -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" 2>/dev/null

# SUID/SGID files
echo "--- SUID/SGID Files ---"
sudo find / -type f -perm /6000 -ls 2>/dev/null

# Firewall status
echo "--- Firewall Status ---"
sudo ufw status verbose

# SSH configuration
echo "--- SSH Configuration ---"
grep -v '^#' /etc/ssh/sshd_config | grep -v '^$'

# Package updates
echo "--- Package Updates ---"
sudo apt update && sudo apt list --upgradable

echo "=== End of Audit ==="
