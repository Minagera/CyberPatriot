#!/bin/bash
# CyberPatriot Linux Baseline Comparison Script (unique)

BASELINE="$HOME/baseline"

meld "$BASELINE/etc/passwd" /etc/passwd &
meld "$BASELINE/etc/ssh/sshd_config" /etc/ssh/sshd_config &
dpkg --get-selections > /tmp/current_packages.txt
meld "$BASELINE/packages.txt" /tmp/current_packages.txt &
systemctl list-unit-files --state=enabled > /tmp/current_services.txt
meld "$BASELINE/enabled-services.txt" /tmp/current_services.txt &
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > /tmp/current_suid_sgid.txt
meld "$BASELINE/suid_sgid_files.txt" /tmp/current_suid_sgid.txt &
find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > /tmp/current_world_writable.txt
meld "$BASELINE/world_writable_files.txt" /tmp/current_world_writable.txt &
wait

echo "Comparison complete. Review Meld windows."
