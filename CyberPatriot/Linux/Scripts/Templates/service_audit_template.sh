#!/bin/bash
# Service Audit Template Script for CyberPatriot

echo "=== Service Audit ==="

# List all running services
systemctl list-units --type=service --state=active

# List all enabled services
systemctl list-unit-files --type=service | grep enabled

echo "=== End of Service Audit ==="
