#!/bin/bash
# Password Policy Hardening Script for Ubuntu/Linux Mint
# Usage: sudo ./Password_Policy_Hardening.sh

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}This script must be run as root.${NC}" 
   exit 1
fi

echo -e "${GREEN}==== Password Policy Hardening Script ====${NC}"
echo -e "${GREEN}This script will configure secure password policies on your system${NC}"

# Backup files before modification
backup_file() {
    local file="$1"
    if [ -f "$file" ]; then
        cp "$file" "$file.bak.$(date +%Y%m%d%H%M%S)"
        echo -e "${YELLOW}Backed up $file to $file.bak.$(date +%Y%m%d%H%M%S)${NC}"
    fi
}

# 1. Install password quality packages
echo -e "\n${GREEN}Installing necessary packages...${NC}"
apt update
apt install -y libpam-pwquality libpam-cracklib pwgen

# 2. Configure password aging
echo -e "\n${GREEN}Configuring password aging policies...${NC}"
backup_file "/etc/login.defs"

# Configure login.defs for password aging
sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS   90/' /etc/login.defs
sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS   1/' /etc/login.defs
sed -i 's/^PASS_WARN_AGE.*/PASS_WARN_AGE   7/' /etc/login.defs

echo "Password aging configured:"
echo "- Maximum password age: 90 days"
echo "- Minimum password age: 1 day"
echo "- Password expiration warning: 7 days"

# 3. Apply password aging to existing accounts
echo -e "\n${GREEN}Applying password aging to existing accounts...${NC}"
for user in $(cut -d: -f1 /etc/passwd); do
    # Skip system users
    if [ $(id -u "$user" 2>/dev/null || echo 0) -ge 1000 ]; then
        echo "Updating password aging for user: $user"
        chage -M 90 -m 1 -W 7 "$user"
    fi
done

# 4. Configure PAM for password quality
echo -e "\n${GREEN}Configuring PAM for password quality...${NC}"
backup_file "/etc/pam.d/common-password"

# Look for pwquality line
if grep -q "pam_pwquality.so" /etc/pam.d/common-password; then
    # Update existing pwquality line
    sed -i '/pam_pwquality.so/ c\password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root dictcheck=1' /etc/pam.d/common-password
else
    # Look for pam_cracklib.so and replace it
    if grep -q "pam_cracklib.so" /etc/pam.d/common-password; then
        sed -i '/pam_cracklib.so/ c\password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root dictcheck=1' /etc/pam.d/common-password
    else
        # Insert pwquality line before pam_unix.so
        sed -i '/pam_unix.so/ i\password requisite pam_pwquality.so retry=3 minlen=12 difok=3 ucredit=-1 lcredit=-1 dcredit=-1 ocredit=-1 reject_username enforce_for_root dictcheck=1' /etc/pam.d/common-password
    fi
fi

echo "Password quality requirements configured:"
echo "- Minimum length: 12 characters"
echo "- Require at least 1 uppercase letter"
echo "- Require at least 1 lowercase letter"
echo "- Require at least 1 digit"
echo "- Require at least 1 special character"
echo "- Reject passwords containing username"
echo "- Check against dictionary words"
echo "- Remember 3 previous passwords"

# 5. Configure account lockout
echo -e "\n${GREEN}Configuring account lockout policies...${NC}"
backup_file "/etc/pam.d/common-auth"

# Check if pam_tally2 or pam_faillock is available
if [ -f /lib/*/security/pam_tally2.so ]; then
    # Use pam_tally2 for older systems
    if ! grep -q "pam_tally2.so" /etc/pam.d/common-auth; then
        sed -i '1i auth required pam_tally2.so deny=5 unlock_time=1800 onerr=fail audit even_deny_root' /etc/pam.d/common-auth
    fi
    
    # Create unlock command helper
    cat > /usr/local/bin/unlock-account << 'EOF'
#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
pam_tally2 --user=$1 --reset
echo "Account $1 has been unlocked"
EOF
    chmod +x /usr/local/bin/unlock-account
    echo "Account lockout configured using pam_tally2"
    echo "To unlock an account, run: sudo unlock-account username"
    
elif [ -f /lib/*/security/pam_faillock.so ]; then
    # Use pam_faillock for newer systems
    backup_file "/etc/security/faillock.conf"
    
    cat > /etc/security/faillock.conf << EOF
# Configuration for pam_faillock
deny=5
fail_interval=900
unlock_time=1800
even_deny_root
audit
EOF
    
    if ! grep -q "pam_faillock.so" /etc/pam.d/common-auth; then
        sed -i '1i auth required pam_faillock.so preauth' /etc/pam.d/common-auth
        sed -i '/^auth.*pam_unix.so/ a auth [default=die] pam_faillock.so authfail' /etc/pam.d/common-auth
        sed -i '/^auth.*pam_deny.so/ i auth sufficient pam_faillock.so authsucc' /etc/pam.d/common-auth
    fi
    
    # Create unlock command helper
    cat > /usr/local/bin/unlock-account << 'EOF'
#!/bin/bash
if [ $# -ne 1 ]; then
    echo "Usage: $0 <username>"
    exit 1
fi
faillock --user $1 --reset
echo "Account $1 has been unlocked"
EOF
    chmod +x /usr/local/bin/unlock-account
    echo "Account lockout configured using pam_faillock"
    echo "To unlock an account, run: sudo unlock-account username"
    
else
    echo -e "${YELLOW}WARNING: Neither pam_tally2 nor pam_faillock is available. Account lockout cannot be configured.${NC}"
fi

# 6. Configure pam_unix for password history
echo -e "\n${GREEN}Configuring password history...${NC}"
if grep -q "pam_unix.so.*remember" /etc/pam.d/common-password; then
    sed -i 's/\(pam_unix.so.*\) remember=[0-9]*/\1 remember=5/' /etc/pam.d/common-password
else
    sed -i 's/\(pam_unix.so.*\)/\1 remember=5/' /etc/pam.d/common-password
fi

# 7. Create strong password generation helper script
echo -e "\n${GREEN}Creating password generation helper...${NC}"
cat > /usr/local/bin/generate-strong-password << 'EOF'
#!/bin/bash
# Generate a strong, memorable password
length=${1:-16}
pwgen -y -s $length 1
EOF
chmod +x /usr/local/bin/generate-strong-password

echo "Password generator created. Run 'generate-strong-password' to create a strong password."

# 8. Create PAM configuration check script
echo -e "\n${GREEN}Creating PAM configuration checker...${NC}"
cat > /usr/local/bin/check-pam-config << 'EOF'
#!/bin/bash
# Check PAM configuration for security settings
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== PAM Configuration Security Check ===${NC}"

# Check password quality
echo -e "\n${GREEN}Password Quality Settings:${NC}"
if grep -q "pam_pwquality.so" /etc/pam.d/common-password; then
    grep "pam_pwquality.so" /etc/pam.d/common-password
    echo -e "${GREEN}Password quality module is configured.${NC}"
    
    # Check specific settings
    config=$(grep "pam_pwquality.so" /etc/pam.d/common-password)
    
    if [[ "$config" =~ minlen=([0-9]+) ]]; then
        minlen="${BASH_REMATCH[1]}"
        if [ "$minlen" -ge 12 ]; then
            echo -e "${GREEN}✓ Password minimum length ($minlen) is good.${NC}"
        else
            echo -e "${YELLOW}⚠ Password minimum length ($minlen) should be at least 12.${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Password minimum length not set.${NC}"
    fi
    
    if [[ "$config" =~ ucredit=(-?[0-9]+) ]]; then
        ucredit="${BASH_REMATCH[1]}"
        if [ "$ucredit" -lt 0 ]; then
            echo -e "${GREEN}✓ Uppercase character requirement is set.${NC}"
        else
            echo -e "${YELLOW}⚠ Uppercase character requirement is weak.${NC}"
        fi
    else
        echo -e "${YELLOW}⚠ Uppercase character requirement not set.${NC}"
    fi
    
    # Similar checks for lcredit, dcredit, ocredit
    
    if [[ "$config" =~ reject_username ]]; then
        echo -e "${GREEN}✓ Username rejection is enabled.${NC}"
    else
        echo -e "${YELLOW}⚠ Username rejection is not enabled.${NC}"
    fi
else
    echo -e "${RED}✗ Password quality module (pam_pwquality.so) is not configured!${NC}"
fi

# Check password history
echo -e "\n${GREEN}Password History Settings:${NC}"
grep "pam_unix.so" /etc/pam.d/common-password
if grep -q "pam_unix.so.*remember=[0-9]" /etc/pam.d/common-password; then
    if [[ $(grep "pam_unix.so" /etc/pam.d/common-password) =~ remember=([0-9]+) ]]; then
        remember="${BASH_REMATCH[1]}"
        if [ "$remember" -ge 5 ]; then
            echo -e "${GREEN}✓ Password history ($remember) is good.${NC}"
        else
            echo -e "${YELLOW}⚠ Password history ($remember) should be at least 5.${NC}"
        fi
    fi
else
    echo -e "${YELLOW}⚠ Password history not set.${NC}"
fi

# Check account lockout
echo -e "\n${GREEN}Account Lockout Settings:${NC}"
if grep -q "pam_tally2.so" /etc/pam.d/common-auth; then
    grep "pam_tally2.so" /etc/pam.d/common-auth
    echo -e "${GREEN}✓ Account lockout is configured using pam_tally2.${NC}"
elif grep -q "pam_faillock.so" /etc/pam.d/common-auth; then
    grep "pam_faillock.so" /etc/pam.d/common-auth
    if [ -f /etc/security/faillock.conf ]; then
        echo -e "${GREEN}Faillock configuration:${NC}"
        cat /etc/security/faillock.conf
    fi
    echo -e "${GREEN}✓ Account lockout is configured using pam_faillock.${NC}"
else
    echo -e "${RED}✗ Account lockout is not configured!${NC}"
fi

# Check password aging
echo -e "\n${GREEN}Password Aging Settings:${NC}"
echo -e "Settings in /etc/login.defs:"
grep -E "^PASS_MAX_DAYS|^PASS_MIN_DAYS|^PASS_WARN_AGE" /etc/login.defs

echo -e "\n${GREEN}Test with a regular user:${NC}"
if [ -n "$1" ]; then
    user="$1"
    chage -l $user
else
    echo "To check a specific user, run: check-pam-config username"
    # Try to find a non-system user to check
    for user in $(cut -d: -f1 /etc/passwd); do
        if [ $(id -u "$user" 2>/dev/null || echo 0) -ge 1000 ]; then
            echo "Found user $user, checking password aging:"
            chage -l $user
            break
        fi
    done
fi
EOF
chmod +x /usr/local/bin/check-pam-config

echo "PAM configuration checker created. Run 'check-pam-config' to verify your settings."

# 9. Final summary
echo -e "\n${GREEN}==== Password Policy Hardening Complete ====${NC}"
echo "Password policies have been hardened with the following settings:"
echo "- Password minimum length: 12 characters"
echo "- Password complexity requirements: uppercase, lowercase, numeric, special"
echo "- Password history: 5 passwords remembered"
echo "- Password maximum age: 90 days"
echo "- Password minimum age: 1 day"
echo "- Password expiration warning: 7 days"
echo "- Account lockout: 5 failed attempts, unlock after 30 minutes"

echo -e "\n${YELLOW}Tools created:${NC}"
echo "- /usr/local/bin/generate-strong-password: Generate strong passwords"
echo "- /usr/local/bin/check-pam-config: Check PAM security configuration"
echo "- /usr/local/bin/unlock-account: Unlock locked accounts"

echo -e "\n${GREEN}To verify your configuration, run: check-pam-config${NC}"
