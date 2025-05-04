#!/bin/bash
# Find World-Writable Files Script Template (for CyberPatriot)

echo "World-writable files (excluding /proc, /sys, /run, /dev):"
find / -type f -perm -o+w \
  -not -path "/proc/*" -not -path "/sys/*" -not -path "/run/*" -not -path "/dev/*" \
  -exec ls -l {} \; 2>/dev/null
