#!/bin/bash
# CyberPatriot Linux Baselining Script (Unique, original)
# Exports key system state for comparison in CyberPatriot competitions

BASELINE_DIR="$HOME/linux_baseline"
mkdir -p "$BASELINE_DIR/etc/ssh" "$BASELINE_DIR/etc/pam.d"

# Copy critical config files
cp /etc/passwd "$BASELINE_DIR/etc/"
cp /etc/group "$BASELINE_DIR/etc/"
cp /etc/ssh/sshd_config "$BASELINE_DIR/etc/ssh/" 2>/dev/null
cp /etc/pam.d/common-password "$BASELINE_DIR/etc/pam.d/" 2>/dev/null

# List installed packages
if command -v dpkg &>/dev/null; then
    dpkg --get-selections > "$BASELINE_DIR/packages.txt"
elif command -v rpm &>/dev/null; then
    rpm -qa > "$BASELINE_DIR/packages.txt"
fi

# List enabled services
systemctl list-unit-files --state=enabled > "$BASELINE_DIR/enabled-services.txt"

# List users and groups
getent passwd > "$BASELINE_DIR/passwd.txt"
getent group > "$BASELINE_DIR/group.txt"

# List SUID/SGID files
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > "$BASELINE_DIR/suid_sgid_files.txt"

# List world-writable files
find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > "$BASELINE_DIR/world_writable_files.txt"

echo "Linux baseline exported to $BASELINE_DIR"
