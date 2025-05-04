#!/bin/bash
# UFW Hardening Script Template (for CyberPatriot)

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw enable

echo "UFW firewall hardened and enabled."
