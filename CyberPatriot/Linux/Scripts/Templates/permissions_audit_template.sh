#!/bin/bash
# Permissions Audit Template Script for CyberPatriot

echo "=== Permissions Audit ==="

# Find world-writable files
sudo find / -type f -perm -o+w -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" 2>/dev/null

# Find SUID/SGID files
sudo find / -type f -perm /6000 -ls 2>/dev/null

# Fix permissions on critical files (example)
# sudo chmod 644 /etc/passwd
# sudo chmod 640 /etc/shadow

echo "=== End of Permissions Audit ==="
