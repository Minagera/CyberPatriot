#!/bin/bash
#==============================================================================
# System Security Audit Script for Ubuntu/Linux Mint
# Purpose: Perform a comprehensive security audit of the system
# Usage: Run as root or with sudo
#==============================================================================

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Output file setup
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="/tmp/security-audit-$TIMESTAMP"
REPORT_FILE="$OUTPUT_DIR/security-report.txt"
ISSUES_FILE="$OUTPUT_DIR/security-issues.txt"
CSV_FILE="$OUTPUT_DIR/security-summary.csv"

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}This script must be run as root or with sudo privileges.${NC}"
  exit 1
fi

# Print header
echo -e "${BLUE}====================================================================${NC}"
echo -e "${BLUE}           LINUX SYSTEM SECURITY AUDIT SCRIPT                      ${NC}"
echo -e "${BLUE}====================================================================${NC}"
echo -e "${CYAN}Started at: $(date)${NC}"
echo -e "${CYAN}System: $(hostname)${NC}"
echo -e "${CYAN}Kernel: $(uname -r)${NC}"
echo -e "${CYAN}OS: $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2- | tr -d \")${NC}"
echo -e "${BLUE}====================================================================${NC}"
echo

# Initialize report file
echo "SYSTEM SECURITY AUDIT REPORT" > "$REPORT_FILE"
echo "Generated on: $(date)" >> "$REPORT_FILE"
echo "Hostname: $(hostname)" >> "$REPORT_FILE"
echo "OS: $(lsb_release -ds 2>/dev/null || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2- | tr -d \")" >> "$REPORT_FILE"
echo "Kernel: $(uname -r)" >> "$REPORT_FILE"
echo "===================================================================" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"

# Initialize issues file
echo "SECURITY ISSUES FOUND" > "$ISSUES_FILE"
echo "Generated on: $(date)" >> "$ISSUES_FILE"
echo "Hostname: $(hostname)" >> "$ISSUES_FILE"
echo "===================================================================" >> "$ISSUES_FILE"
echo >> "$ISSUES_FILE"

# Initialize CSV summary
echo "Category,Test,Status,Notes" > "$CSV_FILE"

# Function to add a section header to the report
add_section_header() {
  echo -e "${PURPLE}$1${NC}"
  echo "=== $1 ===" >> "$REPORT_FILE"
  echo >> "$REPORT_FILE"
}

# Function to add a test result to the report and CSV
# Parameters: $1=Category, $2=Test Name, $3=Status (PASS/FAIL/WARNING/INFO), $4=Details
add_result() {
  local category="$1"
  local test="$2"
  local status="$3"
  local details="$4"
  
  # Add to main report
  echo "$test: $status" >> "$REPORT_FILE"
  echo "$details" >> "$REPORT_FILE"
  echo >> "$REPORT_FILE"
  
  # Add to CSV summary
  details_csv=$(echo "$details" | tr '\n' ' ' | tr ',' '|')
  echo "\"$category\",\"$test\",\"$status\",\"$details_csv\"" >> "$CSV_FILE"
  
  # Print to console with color
  case "$status" in
    PASS)
      echo -e "${GREEN}[PASS]${NC} $test"
      ;;
    FAIL)
      echo -e "${RED}[FAIL]${NC} $test"
      echo "$test: FAIL" >> "$ISSUES_FILE"
      echo "$details" >> "$ISSUES_FILE"
      echo >> "$ISSUES_FILE"
      ;;
    WARNING)
      echo -e "${YELLOW}[WARNING]${NC} $test"
      echo "$test: WARNING" >> "$ISSUES_FILE"
      echo "$details" >> "$ISSUES_FILE"
      echo >> "$ISSUES_FILE"
      ;;
    INFO)
      echo -e "${BLUE}[INFO]${NC} $test"
      ;;
    *)
      echo -e "$test: $status"
      ;;
  esac
  
  # Print details indented
  if [ -n "$details" ]; then
    echo -e "  $details" | sed 's/^/  /'
  fi
  echo
}

#==============================================================================
# User Account Audit
#==============================================================================
add_section_header "USER ACCOUNTS AUDIT"

# Check for users with UID 0 (should only be root)
root_users=$(awk -F: '$3 == 0 {print $1}' /etc/passwd | grep -v "^root$")
if [ -z "$root_users" ]; then
  add_result "User Security" "UID 0 Accounts" "PASS" "Only root has UID 0"
else
  add_result "User Security" "UID 0 Accounts" "FAIL" "Unauthorized users with UID 0 found: $root_users"
fi

# Check for users with empty passwords
empty_passwords=$(awk -F: '($2 == "" || $2 == "*" || $2 == "!") && $1 != "root" && $1 != "sync" && $1 != "shutdown" && $1 != "halt" && $3 >= 1000 {print $1}' /etc/shadow)
if [ -z "$empty_passwords" ]; then
  add_result "User Security" "Empty Passwords" "PASS" "No users with empty passwords found"
else
  add_result "User Security" "Empty Passwords" "FAIL" "Users with empty passwords: $empty_passwords"
fi

# Check for users who can login with shells
users_with_shells=$(grep -v '/usr/sbin/nologin\|/bin/false\|/sbin/nologin' /etc/passwd | awk -F: '{print $1 " (UID: " $3 ", Shell: " $7 ")"}')
add_result "User Security" "User Login Shells" "INFO" "Users with login shells:\n$users_with_shells"

# Check sudo access
sudo_users=$(grep -Po '^sudo:.*:\K.*$' /etc/group)
if [ -n "$sudo_users" ]; then
  add_result "User Security" "Sudo Access" "INFO" "Users with sudo access: $sudo_users"
else
  add_result "User Security" "Sudo Access" "INFO" "No users in sudo group (check /etc/sudoers directly)"
fi

# Check sudoers file
sudoers_content=$(grep -v '^#\|^$' /etc/sudoers 2>/dev/null)
sudoers_includes=$(ls -la /etc/sudoers.d/ 2>/dev/null)
if [ -n "$sudoers_content" ] || [ -n "$sudoers_includes" ]; then
  add_result "User Security" "Sudoers Configuration" "INFO" "Sudoers content:\n$sudoers_content\n\nSudoers includes:\n$sudoers_includes"
else
  add_result "User Security" "Sudoers Configuration" "INFO" "Could not read sudoers file or no content"
fi

# Check password policy
pw_max_days=$(grep "^PASS_MAX_DAYS" /etc/login.defs | awk '{print $2}')
pw_min_days=$(grep "^PASS_MIN_DAYS" /etc/login.defs | awk '{print $2}')
pw_warn_age=$(grep "^PASS_WARN_AGE" /etc/login.defs | awk '{print $2}')
password_policy="PASS_MAX_DAYS: $pw_max_days\nPASS_MIN_DAYS: $pw_min_days\nPASS_WARN_AGE: $pw_warn_age"

if [ "$pw_max_days" -le 90 ] && [ "$pw_min_days" -ge 1 ] && [ "$pw_warn_age" -ge 7 ]; then
  add_result "User Security" "Password Aging Policy" "PASS" "Password aging policy meets requirements:\n$password_policy"
else
  add_result "User Security" "Password Aging Policy" "WARNING" "Password aging policy doesn't meet recommendations:\n$password_policy\nRecommended: PASS_MAX_DAYS ≤ 90, PASS_MIN_DAYS ≥ 1, PASS_WARN_AGE ≥ 7"
fi

# Check for PAM password quality requirements
if [ -f /etc/pam.d/common-password ]; then
  pam_pwquality=$(grep "pam_pwquality.so" /etc/pam.d/common-password)
  if [ -n "$pam_pwquality" ]; then
    minlen=$(echo "$pam_pwquality" | grep -o "minlen=[0-9]*" | cut -d= -f2)
    if [ -n "$minlen" ] && [ "$minlen" -ge 12 ]; then
      add_result "User Security" "Password Complexity" "PASS" "Password complexity policy configured: $pam_pwquality"
    else
      add_result "User Security" "Password Complexity" "WARNING" "Password complexity inadequate or not found: $pam_pwquality"
    fi
  else
    add_result "User Security" "Password Complexity" "WARNING" "Password complexity (pam_pwquality) not configured"
  fi
else
  add_result "User Security" "Password Complexity" "WARNING" "PAM common-password file not found"
fi

#==============================================================================
# System Updates and Packages
#==============================================================================
add_section_header "SYSTEM UPDATES AND PACKAGES"

# Check for available updates
echo -e "${CYAN}Checking for system updates (this may take a moment)...${NC}"
apt_update_output=$(apt update 2>&1)
updates_available=$(apt list --upgradable 2>/dev/null | grep -v "Listing..." | wc -l)

if [ "$updates_available" -eq 0 ]; then
  add_result "System Updates" "Available Updates" "PASS" "System is up to date"
else
  add_result "System Updates" "Available Updates" "FAIL" "$updates_available update(s) available. Run 'apt upgrade' to install them."
fi

# Check if automatic updates are enabled
if [ -f /etc/apt/apt.conf.d/20auto-upgrades ]; then
  auto_updates=$(grep "Unattended-Upgrade \"1\"" /etc/apt/apt.conf.d/20auto-upgrades)
  if [ -n "$auto_updates" ]; then
    add_result "System Updates" "Automatic Updates" "PASS" "Automatic updates are enabled"
  else
    add_result "System Updates" "Automatic Updates" "WARNING" "Automatic updates may not be properly configured"
  fi
else
  add_result "System Updates" "Automatic Updates" "WARNING" "Automatic updates not configured"
fi

# Check for unauthorized/unusual packages
games_installed=$(dpkg -l | grep -i "game" | grep -v "libgame\|gameranger" | wc -l)
if [ "$games_installed" -gt 0 ]; then
  add_result "System Packages" "Games Installed" "WARNING" "Games found installed on the system. Verify if they're authorized."
else
  add_result "System Packages" "Games Installed" "PASS" "No games found installed"
fi

# Check for potentially problematic packages
problem_packages=$(dpkg -l | grep -E "nmap|wireshark|aircrack|john|hydra|netcat|telnetd|ftpd|tightvncserver|snmp|rsh-server")
if [ -n "$problem_packages" ]; then
  add_result "System Packages" "Security Tools" "WARNING" "Potentially sensitive packages installed:\n$problem_packages"
else
  add_result "System Packages" "Security Tools" "PASS" "No questionable packages found"
fi

#==============================================================================
# Service Security
#==============================================================================
add_section_header "SERVICE SECURITY"

# Check for running services
echo -e "${CYAN}Checking services (this may take a moment)...${NC}"
running_services=$(systemctl list-units --type=service --state=active | grep "\.service" | awk '{print $1}')
add_result "Services" "Running Services" "INFO" "Running services:\n$running_services"

# Check for insecure services
insecure_services=$(systemctl is-active telnet.service rsh.service rlogin.service rexec.service vsftpd.service 2>/dev/null)
if [ -n "$insecure_services" ]; then
  add_result "Services" "Insecure Services" "FAIL" "Insecure services active: $insecure_services"
else
  add_result "Services" "Insecure Services" "PASS" "No insecure services running"
fi

# Check SSH configuration
if systemctl is-active ssh.service &>/dev/null || systemctl is-active sshd.service &>/dev/null; then
  if [ -f /etc/ssh/sshd_config ]; then
    root_login=$(grep "^PermitRootLogin" /etc/ssh/sshd_config | awk '{print $2}')
    password_auth=$(grep "^PasswordAuthentication" /etc/ssh/sshd_config | awk '{print $2}')
    protocol_version=$(grep "^Protocol" /etc/ssh/sshd_config | awk '{print $2}')
    
    ssh_issues=""
    if [[ "$root_login" == "yes" ]]; then
      ssh_issues+="- Root login is permitted\n"
    fi
    
    if [[ -z "$protocol_version" || "$protocol_version" != "2" ]]; then
      ssh_issues+="- Protocol may not be set to 2\n"
    fi
    
    if [ -n "$ssh_issues" ]; then
      add_result "Services" "SSH Configuration" "WARNING" "SSH security issues found:\n$ssh_issues"
    else
      add_result "Services" "SSH Configuration" "PASS" "SSH appears to be configured securely"
    fi
  else
    add_result "Services" "SSH Configuration" "WARNING" "SSH is running but config file not found at /etc/ssh/sshd_config"
  fi
else
  add_result "Services" "SSH Configuration" "INFO" "SSH service not running"
fi

#==============================================================================
# Network Security
#==============================================================================
add_section_header "NETWORK SECURITY"

# Check open ports
open_ports=$(ss -tulpn | grep LISTEN)
add_result "Network" "Open Ports" "INFO" "Open ports:\n$open_ports"

# Check firewall status (ufw)
if command -v ufw &>/dev/null; then
  ufw_status=$(ufw status verbose)
  if echo "$ufw_status" | grep -q "Status: active"; then
    add_result "Network" "Firewall" "PASS" "UFW firewall is active:\n$ufw_status"
  else
    add_result "Network" "Firewall" "FAIL" "UFW firewall is installed but not active"
  fi
else
  add_result "Network" "Firewall" "FAIL" "UFW firewall not installed"
fi

# Check network parameters
ip_forward=$(cat /proc/sys/net/ipv4/ip_forward)
if [ "$ip_forward" -eq 0 ]; then
  add_result "Network" "IP Forwarding" "PASS" "IP forwarding is disabled"
else
  add_result "Network" "IP Forwarding" "WARNING" "IP forwarding is enabled (may be normal for routers/gateways)"
fi

# Check for other important network parameters
rp_filter=$(cat /proc/sys/net/ipv4/conf/all/rp_filter)
accept_redirects=$(cat /proc/sys/net/ipv4/conf/all/accept_redirects)
accept_source_route=$(cat /proc/sys/net/ipv4/conf/all/accept_source_route)

network_params="Reverse Path Filtering: $rp_filter (should be 1)\n"
network_params+="Accept ICMP Redirects: $accept_redirects (should be 0)\n"
network_params+="Accept Source Route: $accept_source_route (should be 0)"

if [ "$rp_filter" -eq 1 ] && [ "$accept_redirects" -eq 0 ] && [ "$accept_source_route" -eq 0 ]; then
  add_result "Network" "Network Parameters" "PASS" "Network parameters correctly set:\n$network_params"
else
  add_result "Network" "Network Parameters" "WARNING" "Some network parameters are not securely configured:\n$network_params"
fi

#==============================================================================
# File System Security
#==============================================================================
add_section_header "FILE SYSTEM SECURITY"

# Check for world-writable files in /etc
world_writable_etc=$(find /etc -type f -perm -002 -ls 2>/dev/null)
if [ -z "$world_writable_etc" ]; then
  add_result "File System" "World-Writable Files in /etc" "PASS" "No world-writable files found in /etc"
else
  add_result "File System" "World-Writable Files in /etc" "FAIL" "World-writable files found in /etc:\n$world_writable_etc"
fi

# Check sticky bit on world-writable directories
world_writable_dirs=$(find / -path /proc -prune -o -type d -perm -0002 -a ! -perm -1000 -ls 2>/dev/null)
if [ -z "$world_writable_dirs" ]; then
  add_result "File System" "World-Writable Directories" "PASS" "All world-writable directories have the sticky bit set"
else
  add_result "File System" "World-Writable Directories" "WARNING" "World-writable directories without sticky bit found:\n$world_writable_dirs"
fi

# Check for unauthorized SUID/SGID binaries
echo -e "${CYAN}Checking for SUID/SGID binaries (this may take a moment)...${NC}"
suid_files=$(find / -path /proc -prune -o -type f -perm -4000 -ls 2>/dev/null)
sgid_files=$(find / -path /proc -prune -o -type f -perm -2000 -ls 2>/dev/null)

add_result "File System" "SUID Files" "INFO" "SUID files found:\n$suid_files"
add_result "File System" "SGID Files" "INFO" "SGID files found:\n$sgid_files"

# Check sensitive file permissions
passwd_perm=$(stat -c "%a %u %g" /etc/passwd)
shadow_perm=$(stat -c "%a %u %g" /etc/shadow)
group_perm=$(stat -c "%a %u %g" /etc/group)
gshadow_perm=$(stat -c "%a %u %g" /etc/gshadow)

sensitive_file_perms="passwd: $passwd_perm (should be 644 0 0)\n"
sensitive_file_perms+="shadow: $shadow_perm (should be 640 0 0 or 600 0 0)\n"
sensitive_file_perms+="group: $group_perm (should be 644 0 0)\n"
sensitive_file_perms+="gshadow: $gshadow_perm (should be 640 0 0 or 600 0 0)"

if [[ "$passwd_perm" =~ ^644 ]]; then
  passwd_ok=true
else
  passwd_ok=false
fi

if [[ "$shadow_perm" =~ ^(640|600) ]]; then
  shadow_ok=true
else
  shadow_ok=false
fi

if [[ "$group_perm" =~ ^644 ]]; then
  group_ok=true
else
  group_ok=false
fi

if [[ "$gshadow_perm" =~ ^(640|600) ]]; then
  gshadow_ok=true
else
  gshadow_ok=false
fi

if [ "$passwd_ok" = true ] && [ "$shadow_ok" = true ] && [ "$group_ok" = true ] && [ "$gshadow_ok" = true ]; then
  add_result "File System" "Sensitive File Permissions" "PASS" "Sensitive files have correct permissions:\n$sensitive_file_perms"
else
  add_result "File System" "Sensitive File Permissions" "FAIL" "Some sensitive files have incorrect permissions:\n$sensitive_file_perms"
fi

#==============================================================================
# System Security Settings
#==============================================================================
add_section_header "SYSTEM SECURITY SETTINGS"

# Check AppArmor status
if command -v aa-status &>/dev/null; then
  apparmor_status=$(aa-status)
  if echo "$apparmor_status" | grep -q "profiles are loaded"; then
    add_result "System Security" "AppArmor" "PASS" "AppArmor is enabled and profiles are loaded:\n$apparmor_status"
  else
    add_result "System Security" "AppArmor" "WARNING" "AppArmor may not be properly configured:\n$apparmor_status"
  fi
else
  add_result "System Security" "AppArmor" "WARNING" "AppArmor not installed"
fi

# Check for suspicious cron jobs
echo -e "${CYAN}Checking for suspicious cron jobs...${NC}"
cron_jobs=$(find /etc/cron* -type f -not -name "*.placeholder" -exec ls -la {} \; 2>/dev/null)
user_cron_jobs=$(for user in $(cut -f1 -d: /etc/passwd); do echo "$user:"; crontab -u "$user" -l 2>/dev/null; done)

add_result "System Security" "Cron Jobs" "INFO" "System cron jobs:\n$cron_jobs\n\nUser cron jobs:\n$user_cron_jobs"

# Check core dumps configuration
core_pattern=$(cat /proc/sys/kernel/core_pattern)
core_uses_pid=$(cat /proc/sys/kernel/core_uses_pid)
fs_suid_dumpable=$(cat /proc/sys/fs/suid_dumpable)

if [ "$fs_suid_dumpable" -eq 0 ]; then
  add_result "System Security" "Core Dumps" "PASS" "Core dumps properly restricted (suid_dumpable=$fs_suid_dumpable)"
else
  add_result "System Security" "Core Dumps" "WARNING" "Core dumps may not be properly restricted (suid_dumpable=$fs_suid_dumpable)"
fi

# Check kernel hardening parameters
kernel_mmap_min_addr=$(cat /proc/sys/vm/mmap_min_addr 2>/dev/null)
kernel_kptr_restrict=$(cat /proc/sys/kernel/kptr_restrict 2>/dev/null)
kernel_dmesg_restrict=$(cat /proc/sys/kernel/dmesg_restrict 2>/dev/null)
kernel_randomize_va_space=$(cat /proc/sys/kernel/randomize_va_space 2>/dev/null)

kernel_params="vm.mmap_min_addr = $kernel_mmap_min_addr (should be ≥ 65536)\n"
kernel_params+="kernel.kptr_restrict = $kernel_kptr_restrict (should be 1 or 2)\n"
kernel_params+="kernel.dmesg_restrict = $kernel_dmesg_restrict (should be 1)\n"
kernel_params+="kernel.randomize_va_space = $kernel_randomize_va_space (should be 2)"

if [ "$kernel_mmap_min_addr" -ge 65536 ] && [ "$kernel_kptr_restrict" -ge 1 ] && \
   [ "$kernel_dmesg_restrict" -eq 1 ] && [ "$kernel_randomize_va_space" -eq 2 ]; then
  add_result "System Security" "Kernel Hardening" "PASS" "Kernel security parameters are properly set:\n$kernel_params"
else
  add_result "System Security" "Kernel Hardening" "WARNING" "Some kernel security parameters not optimally configured:\n$kernel_params"
fi

#==============================================================================
# Security Software
#==============================================================================
add_section_header "SECURITY SOFTWARE"

# Check if fail2ban is installed and running
if command -v fail2ban-client &>/dev/null; then
  fail2ban_status=$(fail2ban-client status 2>/dev/null)
  if systemctl is-active fail2ban &>/dev/null; then
    add_result "Security Software" "Fail2ban" "PASS" "Fail2ban is installed and running"
  else
    add_result "Security Software" "Fail2ban" "WARNING" "Fail2ban is installed but not running"
  fi
else
  add_result "Security Software" "Fail2ban" "WARNING" "Fail2ban is not installed"
fi

# Check if rootkit scanner is installed
if command -v rkhunter &>/dev/null; then
  rkhunter_version=$(rkhunter --version | head -1)
  add_result "Security Software" "RKHunter" "PASS" "RKHunter rootkit scanner is installed: $rkhunter_version"
else
  add_result "Security Software" "RKHunter" "WARNING" "RKHunter rootkit scanner is not installed"
fi

# Check if chkrootkit is installed
if command -v chkrootkit &>/dev/null; then
  add_result "Security Software" "Chkrootkit" "PASS" "Chkrootkit rootkit scanner is installed"
else
  add_result "Security Software" "Chkrootkit" "INFO" "Chkrootkit rootkit scanner is not installed"
fi

# Check if AIDE is installed and initialized
if command -v aide &>/dev/null; then
  if [ -f /var/lib/aide/aide.db ]; then
    add_result "Security Software" "AIDE" "PASS" "AIDE file integrity checker is installed and database exists"
  else
    add_result "Security Software" "AIDE" "WARNING" "AIDE is installed but database not found. Run 'sudo aideinit' to initialize"
  fi
else
  add_result "Security Software" "AIDE" "WARNING" "AIDE file integrity checker is not installed"
fi

# Check if audit daemon is running
if command -v auditd &>/dev/null; then
  if systemctl is-active auditd &>/dev/null; then
    audit_rules=$(auditctl -l 2>/dev/null)
    add_result "Security Software" "Audit Daemon" "PASS" "Audit daemon is running with rules:\n$audit_rules"
  else
    add_result "Security Software" "Audit Daemon" "WARNING" "Audit daemon is installed but not running"
  fi
else
  add_result "Security Software" "Audit Daemon" "WARNING" "Audit daemon is not installed"
fi

#==============================================================================
# Hidden Files and Backdoors
#==============================================================================
add_section_header "HIDDEN FILES AND BACKDOORS"

echo -e "${CYAN}Checking for suspicious files (this may take a while)...${NC}"

# Check for hidden files in /home directories with unusual extensions
hidden_executables=$(find /home -name ".*" -type f -perm /111 2>/dev/null)
if [ -n "$hidden_executables" ]; then
  add_result "Suspicious Files" "Hidden Executables" "WARNING" "Hidden executable files found in home directories:\n$hidden_executables"
else
  add_result "Suspicious Files" "Hidden Executables" "PASS" "No hidden executable files found in home directories"
fi

# Check for files with weird names (spaces, control chars, etc.)
weird_filenames=$(find / -name "* *" -o -name "*\\\*" -o -name "*\?*" -o -name "*\**" 2>/dev/null | grep -v "^/proc\|^/sys\|^/snap")
if [ -n "$weird_filenames" ]; then
  add_result "Suspicious Files" "Weird Filenames" "WARNING" "Files with unusual names found:\n$weird_filenames"
else
  add_result "Suspicious Files" "Weird Filenames" "PASS" "No files with unusual names found"
fi

# Check for unauthorized SSH keys
echo -e "${CYAN}Checking for SSH keys...${NC}"
ssh_keys=$(find / -name authorized_keys -o -name "id_*" -not -path "*/snap/*" 2>/dev/null)
if [ -n "$ssh_keys" ]; then
  add_result "Suspicious Files" "SSH Keys" "INFO" "SSH keys found on system (verify they're authorized):\n$ssh_keys"
else
  add_result "Suspicious Files" "SSH Keys" "INFO" "No SSH keys found"
fi

# Look for files in /tmp with suspicious names
suspicious_tmp=$(find /tmp -name ".*" -o -name "....*" -o -name ".ssh*" 2>/dev/null)
if [ -n "$suspicious_tmp" ]; then
  add_result "Suspicious Files" "Temp Directory" "WARNING" "Suspicious files found in /tmp:\n$suspicious_tmp"
else
  add_result "Suspicious Files" "Temp Directory" "PASS" "No suspicious files found in /tmp"
fi

#==============================================================================
# Security Recommendations
#==============================================================================
add_section_header "SECURITY RECOMMENDATIONS"

echo -e "${CYAN}Generating security recommendations...${NC}"

# Read issues file and generate recommendations
issues=$(cat "$ISSUES_FILE" | grep -E "FAIL|WARNING")
if [ -n "$issues" ]; then
  recommendations=""
  
  # User account recommendations
  if grep -q "UID 0 Accounts.*FAIL" "$ISSUES_FILE"; then
    recommendations+="1. Remove unauthorized users with UID 0 immediately. Only root should have UID 0.\n"
  fi
  
  if grep -q "Empty Passwords.*FAIL" "$ISSUES_FILE"; then
    recommendations+="2. Set strong passwords for all accounts with empty passwords.\n"
  fi
  
  if grep -q "Password.*WARNING" "$ISSUES_FILE"; then
    recommendations+="3. Improve password policies by editing /etc/login.defs and implementing PAM password quality requirements.\n"
  fi
  
  # System update recommendations
  if grep -q "Available Updates.*FAIL" "$ISSUES_FILE"; then
    recommendations+="4. Update the system with: sudo apt update && sudo apt upgrade\n"
  fi
  
  if grep -q "Automatic Updates.*WARNING" "$ISSUES_FILE"; then
    recommendations+="5. Configure automatic updates with: sudo apt install unattended-upgrades && sudo dpkg-reconfigure -plow unattended-upgrades\n"
  fi
  
  # Service recommendations
  if grep -q "Insecure Services.*FAIL" "$ISSUES_FILE"; then
    recommendations+="6. Disable or remove insecure services (telnet, rsh, etc.) with: sudo apt purge telnetd rsh-server\n"
  fi
  
  if grep -q "SSH Configuration.*WARNING" "$ISSUES_FILE"; then
    recommendations+="7. Secure SSH by editing /etc/ssh/sshd_config: Set PermitRootLogin no, Protocol 2, etc.\n"
  fi
  
  # Firewall recommendations
  if grep -q "Firewall.*FAIL" "$ISSUES_FILE"; then
    recommendations+="8. Enable and configure the firewall with: sudo apt install ufw && sudo ufw enable\n"
  fi
  
  # File system recommendations
  if grep -q "World-Writable Files.*FAIL" "$ISSUES_FILE"; then
    recommendations+="9. Fix permissions on world-writable files, especially in /etc\n"
  fi
  
  if grep -q "Sensitive File Permissions.*FAIL" "$ISSUES_FILE"; then
    recommendations+="10. Fix permissions on sensitive files: chmod 644 /etc/passwd /etc/group && chmod 640 /etc/shadow /etc/gshadow\n"
  fi
  
  # System security recommendations
  if grep -q "Kernel Hardening.*WARNING" "$ISSUES_FILE"; then
    recommendations+="11. Improve kernel security parameters by editing /etc/sysctl.conf or files in /etc/sysctl.d/\n"
  fi
  
  # Security software recommendations
  if grep -q "Fail2ban.*WARNING" "$ISSUES_FILE"; then
    recommendations+="12. Install and configure Fail2ban: sudo apt install fail2ban\n"
  fi
  
  if grep -q "RKHunter.*WARNING" "$ISSUES_FILE"; then
    recommendations+="13. Install rootkit detection software: sudo apt install rkhunter chkrootkit\n"
  fi
  
  if grep -q "AIDE.*WARNING" "$ISSUES_FILE"; then
    recommendations+="14. Set up file integrity monitoring: sudo apt install aide && sudo aideinit\n"
  fi
  
  if grep -q "Audit Daemon.*WARNING" "$ISSUES_FILE"; then
    recommendations+="15. Configure system auditing: sudo apt install auditd\n"
  fi
  
  # Add to report
  add_result "Recommendations" "Summary" "INFO" "$recommendations"
else
  add_result "Recommendations" "Summary" "INFO" "No critical security issues were found. Continue to monitor and update the system regularly."
fi

#==============================================================================
# Report Summary
#==============================================================================
add_section_header "REPORT SUMMARY"

# Count issues by severity
fail_count=$(grep -c "FAIL" "$CSV_FILE")
warning_count=$(grep -c "WARNING" "$CSV_FILE")
pass_count=$(grep -c "PASS" "$CSV_FILE")
info_count=$(grep -c "INFO" "$CSV_FILE")

# Calculate a simple security score (not scientific)
total_tests=$((fail_count + warning_count + pass_count))
if [ $total_tests -gt 0 ]; then
  security_score=$(( (pass_count * 100) / total_tests ))
else
  security_score=0
fi

# Add colorized rating based on score
if [ $security_score -ge 90 ]; then
  rating="${GREEN}EXCELLENT${NC}"
elif [ $security_score -ge 75 ]; then
  rating="${BLUE}GOOD${NC}"
elif [ $security_score -ge 50 ]; then
  rating="${YELLOW}NEEDS IMPROVEMENT${NC}"
else
  rating="${RED}AT RISK${NC}"
fi

# Display summary
echo -e "${BLUE}====================================================================${NC}"
echo -e "${CYAN}SECURITY AUDIT COMPLETE${NC}"
echo -e "${BLUE}====================================================================${NC}"
echo -e "Tests performed: $total_tests"
echo -e "  ${GREEN}PASS:${NC} $pass_count"
echo -e "  ${RED}FAIL:${NC} $fail_count"
echo -e "  ${YELLOW}WARNING:${NC} $warning_count"
echo -e "  ${BLUE}INFO:${NC} $info_count"
echo
echo -e "Security Score: $security_score% - Rating: $rating"
echo
echo -e "Reports saved to: $OUTPUT_DIR/"
echo -e "${BLUE}====================================================================${NC}"

# Add summary to report file
echo "SECURITY AUDIT SUMMARY" >> "$REPORT_FILE"
echo "=======================" >> "$REPORT_FILE"
echo "Tests performed: $total_tests" >> "$REPORT_FILE"
echo "PASS: $pass_count" >> "$REPORT_FILE"
echo "FAIL: $fail_count" >> "$REPORT_FILE"
echo "WARNING: $warning_count" >> "$REPORT_FILE"
echo "INFO: $info_count" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "Security Score: $security_score%" >> "$REPORT_FILE"
echo >> "$REPORT_FILE"
echo "Completed on: $(date)" >> "$REPORT_FILE"

exit 0
