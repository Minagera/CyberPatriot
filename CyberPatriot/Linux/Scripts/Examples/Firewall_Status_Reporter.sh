#!/bin/bash
# CyberPatriot Example: Firewall Status Reporter

echo "=== CyberPatriot Firewall Status Reporter ==="
if command -v ufw &>/dev/null; then
    ufw status verbose
else
    echo "UFW firewall is not installed."
fi

echo -e "\nCheck complete. Ensure firewall is enabled and configured."
