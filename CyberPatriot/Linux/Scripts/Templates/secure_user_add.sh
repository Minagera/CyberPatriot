#!/bin/bash
# Secure User Add Script Template (for CyberPatriot)
# Usage: sudo ./secure_user_add.sh username

USERNAME="$1"
if [ -z "$USERNAME" ]; then
  echo "Usage: $0 username"
  exit 1
fi

# Add user with secure defaults
useradd -m -s /bin/bash "$USERNAME"
passwd "$USERNAME"
usermod -aG sudo "$USERNAME"
chage -m 7 -M 90 -W 14 "$USERNAME" # Set password aging

echo "User $USERNAME added securely."
