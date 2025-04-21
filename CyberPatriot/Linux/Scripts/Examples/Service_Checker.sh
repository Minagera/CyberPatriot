#!/bin/bash
# CyberPatriot Example: Service Checker Script

echo "=== CyberPatriot Service Checker ==="
echo "Active services:"
systemctl list-units --type=service --state=active | grep ".service" | awk '{print $1}'

echo -e "\nChecking for insecure services (telnet, ftp, rsh):"
for svc in telnet.service vsftpd.service rsh.service; do
    if systemctl is-active --quiet $svc; then
        echo "WARNING: $svc is running!"
    fi
done

echo -e "\nCheck complete. Disable unnecessary or insecure services."
