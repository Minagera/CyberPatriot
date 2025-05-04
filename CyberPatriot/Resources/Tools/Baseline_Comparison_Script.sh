#!/bin/bash
# CyberPatriot Baseline Comparison Script (Linux)
# Compares a clean system to a competition system to identify changes.

if [ $# -ne 2 ]; then
    echo "Usage: $0 <clean_dir> <competition_dir>"
    exit 1
fi

CLEAN="$1"
COMP="$2"

echo "Comparing /etc/passwd..."
diff "$CLEAN/etc/passwd" "$COMP/etc/passwd"

echo "Comparing /etc/shadow..."
sudo diff "$CLEAN/etc/shadow" "$COMP/etc/shadow"

echo "Comparing /etc/group..."
diff "$CLEAN/etc/group" "$COMP/etc/group"

echo "Comparing installed packages..."
diff <(chroot "$CLEAN" dpkg --get-selections | sort) <(chroot "$COMP" dpkg --get-selections | sort)

echo "Comparing running services..."
diff <(chroot "$CLEAN" systemctl list-units --type=service --state=running | sort) <(chroot "$COMP" systemctl list-units --type=service --state=running | sort)

echo "Comparison complete. Review differences for unauthorized changes."
