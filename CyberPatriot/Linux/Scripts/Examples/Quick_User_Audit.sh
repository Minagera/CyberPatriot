#!/bin/bash
# CyberPatriot Example: Quick User Audit Script

echo "=== CyberPatriot Quick User Audit ==="
echo "Regular users (UID >= 1000):"
awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd

echo -e "\nUsers with sudo privileges:"
getent group sudo | cut -d: -f4 | tr ',' '\n'

echo -e "\nUsers with UID 0 (should only be root):"
awk -F: '$3 == 0 {print $1}' /etc/passwd

echo -e "\nAccounts with /bin/bash shell:"
awk -F: '$7 ~ /bash$/ {print $1}' /etc/passwd

echo -e "\nCheck complete. Review for unauthorized or suspicious accounts."
