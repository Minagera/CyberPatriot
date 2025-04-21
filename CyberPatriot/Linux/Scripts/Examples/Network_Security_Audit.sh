#!/bin/bash
# Network Security Audit Script for Ubuntu/Linux Mint
# Usage: sudo ./Network_Security_Audit.sh

# Exit on error
set -e

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Define output file
OUTPUT_DIR="/tmp/network-audit-$(date +%Y%m%d-%H%M%S)"
REPORT_FILE="$OUTPUT_DIR/network-audit-report.txt"
mkdir -p "$OUTPUT_DIR"

# Function for section headers
section_header() {
    echo -e "\n\n===== $1 =====" | tee -a "$REPORT_FILE"
}

echo "Network Security Audit - $(date)" | tee -a "$REPORT_FILE"
echo "System: $(hostname)" | tee -a "$REPORT_FILE"
echo "======================================" | tee -a "$REPORT_FILE"

# Check network interfaces
section_header "NETWORK INTERFACES"
ip addr | tee -a "$REPORT_FILE"

# Check routing table
section_header "ROUTING TABLE"
ip route | tee -a "$REPORT_FILE"

# Check listening ports
section_header "LISTENING PORTS"
ss -tulpn | tee -a "$REPORT_FILE"

# Check established connections
section_header "ESTABLISHED CONNECTIONS"
ss -tn | grep ESTAB | tee -a "$REPORT_FILE"

# Check firewall status
section_header "FIREWALL STATUS"
if command -v ufw >/dev/null 2>&1; then
    echo "UFW is installed" | tee -a "$REPORT_FILE"
    ufw status verbose | tee -a "$REPORT_FILE"
else
    echo "UFW is not installed" | tee -a "$REPORT_FILE"
fi

# Check iptables rules
section_header "IPTABLES RULES"
iptables -L -v | tee -a "$REPORT_FILE"

# Check DNS settings
section_header "DNS SETTINGS"
cat /etc/resolv.conf | tee -a "$REPORT_FILE"

# Check hosts file
section_header "HOSTS FILE"
cat /etc/hosts | tee -a "$REPORT_FILE"

# Check network security parameters
section_header "NETWORK SECURITY PARAMETERS"
echo "IP Forwarding: $(cat /proc/sys/net/ipv4/ip_forward)" | tee -a "$REPORT_FILE"
echo "ICMP Echo Ignore Broadcasts: $(cat /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts)" | tee -a "$REPORT_FILE"
echo "TCP SYN Cookies: $(cat /proc/sys/net/ipv4/tcp_syncookies)" | tee -a "$REPORT_FILE"
echo "Accept Source Route: $(cat /proc/sys/net/ipv4/conf/all/accept_source_route)" | tee -a "$REPORT_FILE"
echo "Accept Redirects: $(cat /proc/sys/net/ipv4/conf/all/accept_redirects)" | tee -a "$REPORT_FILE"
echo "Reverse Path Filtering: $(cat /proc/sys/net/ipv4/conf/all/rp_filter)" | tee -a "$REPORT_FILE"

# Check for SSH on non-standard port
section_header "SSH CONFIGURATION"
if [ -f /etc/ssh/sshd_config ]; then
    grep -v "^#" /etc/ssh/sshd_config | grep -v "^$" | tee -a "$REPORT_FILE"
else
    echo "SSH server is not installed or configured" | tee -a "$REPORT_FILE"
fi

# Check for unauthorized SSH keys
section_header "SSH KEYS"
find /home -name "authorized_keys" -exec ls -la {} \; -exec cat {} \; 2>/dev/null | tee -a "$REPORT_FILE"
ls -la /root/.ssh 2>/dev/null | tee -a "$REPORT_FILE"

# Check for security vulnerabilities
section_header "SECURITY ISSUES"

# Check for weak network security settings
if [ "$(cat /proc/sys/net/ipv4/ip_forward)" -eq 1 ]; then
    echo "WARNING: IP Forwarding is enabled" | tee -a "$REPORT_FILE"
fi

if [ "$(cat /proc/sys/net/ipv4/conf/all/accept_redirects)" -eq 1 ]; then
    echo "WARNING: ICMP redirects are accepted" | tee -a "$REPORT_FILE"
fi

if [ "$(cat /proc/sys/net/ipv4/conf/all/accept_source_route)" -eq 1 ]; then
    echo "WARNING: Source route packets are accepted" | tee -a "$REPORT_FILE"
fi

# Check for unprotected ports
if ss -tulpn | grep -q "telnet"; then
    echo "WARNING: Telnet service is running (plain text protocol)" | tee -a "$REPORT_FILE"
fi

if ss -tulpn | grep -q ":23 "; then
    echo "WARNING: Port 23 (Telnet) is open" | tee -a "$REPORT_FILE"
fi

if ss -tulpn | grep -q ":21 "; then
    echo "WARNING: Port 21 (FTP) is open - Consider using SFTP instead" | tee -a "$REPORT_FILE"
fi

# Check if firewall is disabled
if command -v ufw >/dev/null 2>&1; then
    if ! ufw status | grep -q "Status: active"; then
        echo "WARNING: UFW firewall is installed but not active" | tee -a "$REPORT_FILE"
    fi
else
    echo "WARNING: UFW firewall is not installed" | tee -a "$REPORT_FILE"
fi

# Check SSH root login
if [ -f /etc/ssh/sshd_config ] && grep -q "PermitRootLogin yes" /etc/ssh/sshd_config; then
    echo "WARNING: SSH root login is enabled" | tee -a "$REPORT_FILE"
fi

# Summarize
section_header "RECOMMENDATIONS"
echo "1. Ensure firewall is enabled with proper rule sets" | tee -a "$REPORT_FILE"
echo "2. Disable unnecessary network services" | tee -a "$REPORT_FILE"
echo "3. Configure SSH to use key-based authentication" | tee -a "$REPORT_FILE"
echo "4. Disable SSH root login" | tee -a "$REPORT_FILE"
echo "5. Secure network parameters through sysctl.conf" | tee -a "$REPORT_FILE"
echo "6. Monitor active connections regularly" | tee -a "$REPORT_FILE"

echo -e "\nAudit complete! Report saved to $REPORT_FILE"
