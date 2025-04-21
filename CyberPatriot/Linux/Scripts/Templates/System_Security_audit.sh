#!/bin/bash
# CyberPatriot Cadet Security Audit Script (Unique Edition)
# This script helps you check for common Linux security issues.
# Designed for learning and practice, not for production use.

# === Setup Output ===
AUDIT_LOG="/tmp/cadet_audit_$(hostname)_$(date +%Y%m%d_%H%M).txt"
echo "CyberPatriot Security Audit - $(date)" > "$AUDIT_LOG"
echo "Hostname: $(hostname)" >> "$AUDIT_LOG"
echo "----------------------------------------" >> "$AUDIT_LOG"

# === Section 1: User Accounts ===
echo -e "\n[User Accounts]" | tee -a "$AUDIT_LOG"
awk -F: '{if ($3 >= 1000 && $3 < 65534) print "User:", $1, "UID:", $3, "Shell:", $7}' /etc/passwd | tee -a "$AUDIT_LOG"
awk -F: '$3 == 0 {print "Root-level account:", $1}' /etc/passwd | tee -a "$AUDIT_LOG"
echo "Sudo group members:" | tee -a "$AUDIT_LOG"
getent group sudo | cut -d: -f4 | tr ',' '\n' | tee -a "$AUDIT_LOG"

# === Section 2: Password Policy ===
echo -e "\n[Password Policy]" | tee -a "$AUDIT_LOG"
grep -E 'PASS_MAX_DAYS|PASS_MIN_DAYS|PASS_WARN_AGE' /etc/login.defs | tee -a "$AUDIT_LOG"
echo "Sample password aging for sysadmin:" | tee -a "$AUDIT_LOG"
chage -l sysadmin 2>/dev/null | tee -a "$AUDIT_LOG"

# === Section 3: Services and Processes ===
echo -e "\n[Active Services]" | tee -a "$AUDIT_LOG"
systemctl --no-pager --type=service --state=active | head -n 15 | tee -a "$AUDIT_LOG"
echo "Listening ports:" | tee -a "$AUDIT_LOG"
ss -tuln | grep LISTEN | tee -a "$AUDIT_LOG"

# === Section 4: File Permissions ===
echo -e "\n[File Permissions]" | tee -a "$AUDIT_LOG"
echo "World-writable files in /etc:" | tee -a "$AUDIT_LOG"
find /etc -maxdepth 1 -type f -perm -o+w -ls 2>/dev/null | tee -a "$AUDIT_LOG"
echo "SUID files in /usr/local/bin:" | tee -a "$AUDIT_LOG"
find /usr/local/bin -type f -perm -4000 -ls 2>/dev/null | tee -a "$AUDIT_LOG"
ls -l /etc/shadow | tee -a "$AUDIT_LOG"

# === Section 5: Scheduled Tasks ===
echo -e "\n[Cron Jobs]" | tee -a "$AUDIT_LOG"
for cronfile in /etc/cron.d/* /etc/crontab; do
    [ -f "$cronfile" ] && echo "--- $cronfile ---" | tee -a "$AUDIT_LOG" && grep -v '^#' "$cronfile" | tee -a "$AUDIT_LOG"
done

# === Section 6: Firewall and Network ===
echo -e "\n[Firewall Status]" | tee -a "$AUDIT_LOG"
if command -v ufw &>/dev/null; then
    ufw status verbose | tee -a "$AUDIT_LOG"
else
    echo "UFW not installed." | tee -a "$AUDIT_LOG"
fi

# === Section 7: Suspicious Files (Simple Checks) ===
echo -e "\n[Quick Suspicious File Checks]" | tee -a "$AUDIT_LOG"
find /home -name "*.sh" -o -name "*.py" 2>/dev/null | tee -a "$AUDIT_LOG"
find /home -name "*.mp3" -o -name "*.mp4" 2>/dev/null | tee -a "$AUDIT_LOG"

# === Section 8: Summary and Next Steps ===
echo -e "\n[Summary]" | tee -a "$AUDIT_LOG"
echo "Review the above sections for anything that looks unusual or does not match your team's checklist." | tee -a "$AUDIT_LOG"
echo "Remember to:" | tee -a "$AUDIT_LOG"
echo "- Remove unauthorized users" | tee -a "$AUDIT_LOG"
echo "- Fix weak passwords and password policies" | tee -a "$AUDIT_LOG"
echo "- Disable or remove unnecessary services" | tee -a "$AUDIT_LOG"
echo "- Correct file permissions" | tee -a "$AUDIT_LOG"
echo "- Enable and configure the firewall" | tee -a "$AUDIT_LOG"
echo "- Remove suspicious files and scripts" | tee -a "$AUDIT_LOG"

echo -e "\nAudit complete! See $AUDIT_LOG for your results."
