#!/bin/bash
# SSH Hardening Script for Ubuntu/Linux Mint
# Usage: sudo ./SSH_Hardening.sh

# Exit on errors
set -e

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Backup original SSH configuration
echo "Backing up original SSH configuration..."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak.$(date +%Y%m%d%H%M%S)
echo "Backup created at /etc/ssh/sshd_config.bak.$(date +%Y%m%d%H%M%S)"

echo "Starting SSH hardening process..."

# Install SSH if not already installed
if ! dpkg -s openssh-server &>/dev/null; then
    echo "Installing OpenSSH server..."
    apt update
    apt install -y openssh-server
fi

# Function to set configuration parameters
set_ssh_config() {
    local param="$1"
    local value="$2"
    local file="/etc/ssh/sshd_config"
    
    # If parameter exists (commented or not), modify it
    if grep -q "^#*\s*${param}\s" "$file"; then
        # Replace the line (commented or not)
        sed -i "s/^#*\s*${param}\s.*/${param} ${value}/" "$file"
        echo "Updated: ${param} ${value}"
    else
        # Append to file if not present
        echo "${param} ${value}" >> "$file"
        echo "Added: ${param} ${value}"
    fi
}

echo "Configuring SSH server..."

# Protocol settings
set_ssh_config "Protocol" "2"

# Authentication settings
set_ssh_config "PermitRootLogin" "no"
set_ssh_config "PubkeyAuthentication" "yes"
set_ssh_config "PasswordAuthentication" "yes"  # Set to "no" once keys are set up
set_ssh_config "PermitEmptyPasswords" "no"
set_ssh_config "ChallengeResponseAuthentication" "no"
set_ssh_config "UsePAM" "yes"

# Login settings
set_ssh_config "MaxAuthTries" "3"
set_ssh_config "MaxSessions" "2"
set_ssh_config "LoginGraceTime" "60"

# Timeout settings
set_ssh_config "ClientAliveInterval" "300"
set_ssh_config "ClientAliveCountMax" "0"

# Access restriction settings
# Uncomment and modify these based on your needs
# set_ssh_config "AllowUsers" "user1 user2"
# set_ssh_config "AllowGroups" "sshusers sudo"
# set_ssh_config "DenyUsers" "blockeduser1"
# set_ssh_config "DenyGroups" "blockedgroup"

# Forwarding settings
set_ssh_config "X11Forwarding" "no"
set_ssh_config "AllowAgentForwarding" "no"
set_ssh_config "AllowTcpForwarding" "no"
set_ssh_config "PermitTunnel" "no"

# Log level
set_ssh_config "LogLevel" "VERBOSE"

# Other security settings
set_ssh_config "PermitUserEnvironment" "no"
set_ssh_config "StrictModes" "yes"

# SFTP configuration
set_ssh_config "Subsystem" "sftp internal-sftp"

# Specify allowed ciphers
set_ssh_config "Ciphers" "chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr"

# Specify allowed MACs
set_ssh_config "MACs" "hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256"

# Specify allowed key exchange algorithms
set_ssh_config "KexAlgorithms" "curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256"

# Create SSH configuration directory if it doesn't exist
mkdir -p /etc/ssh/sshd_config.d

# Create modular configuration file for other settings
cat > /etc/ssh/sshd_config.d/hardening.conf << EOF
# Additional SSH hardening settings
Banner /etc/issue.net
DebianBanner no
PrintMotd no
PrintLastLog yes
TCPKeepAlive no
Compression no
EOF

# Create a warning banner
echo "Creating SSH warning banner..."
cat > /etc/issue.net << EOF
***************************************************************************
NOTICE TO USERS

This computer system is for authorized users only. Individuals using this
system without authority or in excess of their authority are subject to
having all their activities on this system monitored and recorded.

Anyone using this system expressly consents to such monitoring and is
advised that if monitoring reveals evidence of possible criminal activity,
system personnel may provide the evidence to law enforcement officials.

All users must comply with organization security policies.
***************************************************************************
EOF

# Ensure proper ownership and permissions
echo "Setting correct ownership and permissions..."
chown root:root /etc/ssh/sshd_config
chmod 600 /etc/ssh/sshd_config
chown root:root /etc/issue.net
chmod 644 /etc/issue.net

# Update firewall if UFW is installed
if command -v ufw >/dev/null 2>&1; then
    echo "Configuring UFW firewall for SSH..."
    ufw allow ssh comment "SSH access"
    if ! ufw status | grep -q "Status: active"; then
        ufw --force enable
    fi
fi

# Generate server keys if they don't exist
echo "Checking SSH server keys..."
ssh-keygen -A

# Test configuration
echo "Testing SSH configuration..."
sshd -t
if [ $? -eq 0 ]; then
    echo "Configuration test passed."
    
    # Restart the SSH service
    echo "Restarting SSH service..."
    systemctl restart sshd
    
    # Enable SSH service at boot
    systemctl enable ssh
    
    echo "SSH hardening completed successfully!"
    echo "Note: If using key-based authentication, make sure to add your keys before disabling password authentication."
    echo "Current SSH service status:"
    systemctl status ssh --no-pager
else
    echo "Configuration test failed. SSH service not restarted."
    echo "Please check the configuration and try again."
    exit 1
fi

# Additional recommendations
echo -e "\nAdditional recommendations:"
echo "1. Set up key-based authentication:"
echo "   For each user:"
echo "   - Generate keys: ssh-keygen -t ed25519 -a 100"
echo "   - Copy public key to server: ssh-copy-id user@host"
echo "   - Then disable password authentication by setting 'PasswordAuthentication no'"
echo
echo "2. Consider setting up Fail2ban to protect against brute force attacks:"
echo "   apt install fail2ban"
echo
echo "3. Consider changing the default SSH port in /etc/ssh/sshd_config (after ensuring firewall allows the new port)"
echo
echo "4. Consider implementing port knocking for additional security"
echo
echo "5. Regularly audit SSH login attempts:"
echo "   grep 'sshd' /var/log/auth.log"
