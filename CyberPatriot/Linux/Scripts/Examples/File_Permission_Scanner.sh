#!/bin/bash
# CyberPatriot Example: File Permission Scanner

echo "=== CyberPatriot File Permission Scanner ==="
echo "World-writable files in /etc:"
find /etc -maxdepth 1 -type f -perm -o+w -ls 2>/dev/null

echo -e "\nSUID files in /usr/local/bin:"
find /usr/local/bin -type f -perm -4000 -ls 2>/dev/null

echo -e "\nCheck complete. Review permissions and correct as needed."
