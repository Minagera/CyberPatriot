#!/bin/bash
# CyberPatriot Linux Baseline Creation Script (Ubuntu/Mint)
# Unique, original script for CyberPatriot training

BASELINE="$HOME/baseline"
mkdir -p "$BASELINE/etc/ssh" "$BASELINE/etc/pam.d"

# Copy critical config files
cp /etc/passwd "$BASELINE/etc/"
cp /etc/group "$BASELINE/etc/"
cp /etc/ssh/sshd_config "$BASELINE/etc/ssh/" 2>/dev/null
cp /etc/pam.d/common-password "$BASELINE/etc/pam.d/" 2>/dev/null

# Save package list, enabled services, users/groups
dpkg --get-selections > "$BASELINE/packages.txt"
systemctl list-unit-files --state=enabled > "$BASELINE/enabled-services.txt"
getent passwd > "$BASELINE/passwd.txt"
getent group > "$BASELINE/group.txt"

# SUID/SGID and world-writable files
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > "$BASELINE/suid_sgid_files.txt"
find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > "$BASELINE/world_writable_files.txt"

echo "Linux baseline created at $BASELINE"
