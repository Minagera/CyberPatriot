#!/bin/bash
# CyberPatriot Automated Baselining Comparison Script (Unique, original)

BASELINE_DIR="$HOME/linux_baseline"
TMP_DIR="/tmp/cyberpatriot_compare"
mkdir -p "$TMP_DIR"

meld "$BASELINE_DIR/etc/passwd" /etc/passwd &
meld "$BASELINE_DIR/etc/group" /etc/group &
meld "$BASELINE_DIR/etc/ssh/sshd_config" /etc/ssh/sshd_config &
meld "$BASELINE_DIR/etc/pam.d/common-password" /etc/pam.d/common-password &

if [ -f "$BASELINE_DIR/packages.txt" ]; then
    if command -v dpkg &>/dev/null; then
        dpkg --get-selections > "$TMP_DIR/current_packages.txt"
    elif command -v rpm &>/dev/null; then
        rpm -qa > "$TMP_DIR/current_packages.txt"
    fi
    meld "$BASELINE_DIR/packages.txt" "$TMP_DIR/current_packages.txt" &
fi

systemctl list-unit-files --state=enabled > "$TMP_DIR/current_services.txt"
meld "$BASELINE_DIR/enabled-services.txt" "$TMP_DIR/current_services.txt" &

find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > "$TMP_DIR/current_suid_sgid.txt"
meld "$BASELINE_DIR/suid_sgid_files.txt" "$TMP_DIR/current_suid_sgid.txt" &

find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > "$TMP_DIR/current_world_writable.txt"
meld "$BASELINE_DIR/world_writable_files.txt" "$TMP_DIR/current_world_writable.txt" &

echo "All Meld comparisons launched."
