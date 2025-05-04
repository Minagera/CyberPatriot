# Linux Script Examples for CyberPatriot

This directory contains example Bash scripts designed to help CyberPatriot cadets learn how to automate security checks and fixes on Ubuntu and Linux Mint systems.

## How to Use These Examples

- **Read the script comments** to understand what each script does before running it.
- **Test scripts in a practice VM** to see how they work and what output they produce.
- **Modify scripts** to fit your own needs or to address specific competition scenarios.
- **Use these as inspiration** for your own scripts during competitions.

## Example Scripts Provided

- `Quick_User_Audit.sh`: Lists all users, their groups, and highlights suspicious accounts.
- `Service_Checker.sh`: Shows all running services and flags common insecure ones.
- `File_Permission_Scanner.sh`: Finds world-writable files and SUID/SGID binaries.
- `Firewall_Status_Reporter.sh`: Checks UFW status and lists allowed/blocked ports.
- `secure_user_add.sh`: Adds users with secure defaults and password policies.
- `audit_services.sh`: Lists all running and enabled services.
- `find_world_writable.sh`: Finds world-writable files and directories.
- `ufw_hardening.sh`: Applies recommended UFW firewall rules.
- `ssh_hardening.sh`: Applies secure SSH configuration settings.

## Why Script?

- **Save time**: Automate repetitive checks.
- **Reduce mistakes**: Scripts do the same thing every time.
- **Document your process**: Output can be saved for your competition report.

## How to Use

- Review the script to understand its logic.
- Run the script in a test VM to see its effects.
- Use as a reference when writing your own scripts for exercises or competition.

*Examples are provided for learning and reference. Do not use in production without review!*

```bash
# Example: Basic User Audit Script for CyberPatriot

echo "=== User Audit Report ==="
awk -F: '$3 >= 1000 && $3 < 65534 {print "User:", $1, "UID:", $3, "Shell:", $7}' /etc/passwd
echo "Sudo group members:"
getent group sudo | cut -d: -f4 | tr ',' '\n'
```
