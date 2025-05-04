#!/bin/bash
# Service Audit Script Template (for CyberPatriot)

echo "Active services:"
systemctl list-units --type=service --state=active

echo "Listening ports:"
ss -tulpn

echo "Check for insecure services (telnet, ftp):"
systemctl status telnet
systemctl status vsftpd
