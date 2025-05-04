#!/bin/bash
# Service Hardening Helper Script Template for CyberPatriot

echo "=== Service Hardening Helper ==="

# List all running services
systemctl list-units --type=service --state=active

# List enabled services at boot
systemctl list-unit-files --type=service | grep enabled

# Disable unnecessary services (example)
# sudo systemctl disable --now telnet
# sudo systemctl disable --now vsftpd

echo "=== End of Service Hardening ==="
