#!/bin/bash
# User Account Audit Script Template for CyberPatriot

echo "=== User Account Audit ==="

# List all users with UID >= 1000 (normal users)
awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd

# List all sudo users
echo "Sudo group members:"
getent group sudo | cut -d: -f4 | tr ',' '\n'

# Check for users with UID 0 (root)
echo "Users with UID 0:"
awk -F: '($3 == 0) {print $1}' /etc/passwd

# Check password expiration
echo "Password expiration for users:"
sudo chage -l $(awk -F: '$3 >= 1000 && $3 < 65534 {print $1}' /etc/passwd)

echo "=== End of Audit ==="
