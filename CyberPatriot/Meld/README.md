# Using Meld for CyberPatriot: A Baselining Guide

## Introduction to Meld and Baselining

One of the most powerful strategies mentioned by CyberPatriot National Champion Akshay involves using a tool called **Meld** for baselining. As he explains:

> "Another powerful tool our team used was Meld, which is a visually based diffing and merging tool for files and directories that works on both Linux and Windows. To effectively use Meld, my team meticulously incorporated entire default filesystems into our script, and enhanced its security by implementing our carefully tailored, secure configurations. During competitions, all of our config hardening was done through Meld."

This guide will help you understand what Meld is, why it's so effective for CyberPatriot, and how to incorporate it into your team's competition strategy.

## What is Meld?

Meld is a visual diff and merge tool that helps you compare:
- Individual text files
- Entire directories
- Version-controlled projects

It provides a clear, color-coded interface that makes it easy to spot differences between files or directories. This makes it perfect for identifying changes between a clean system and a potentially compromised one.

## Why Baselining Works in CyberPatriot

Baselining is the process of comparing a known-good configuration to the competition image to identify differences. This approach is extremely effective in CyberPatriot because:

1. **It reveals hidden vulnerabilities** that might not be obvious from checklists
2. **It identifies attacker changes** like modified configuration files
3. **It helps find persistence mechanisms** such as added users or changed permissions
4. **It saves time** by focusing your attention on what's actually different

## Installing Meld

### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install meld
```

### On Windows:
1. Download the installer from the [Meld website](https://meldmerge.org/)
2. Run the installer and follow the prompts
3. Launch Meld from the Start menu

## Setting Up Baseline Files

To effectively use Meld, you need clean baseline files to compare against:

### For Linux:
1. Create a clean installation of the same distribution used in competition (Ubuntu, Debian, etc.)
2. Save copies of important configuration files:
   ```bash
   # Create a baseline directory
   mkdir -p ~/baseline/etc
   
   # Copy important configuration files
   cp /etc/passwd ~/baseline/etc/
   cp /etc/group ~/baseline/etc/
   cp /etc/ssh/sshd_config ~/baseline/etc/ssh/
   cp /etc/pam.d/common-password ~/baseline/etc/pam.d/
   # Add more critical configuration files
   ```

3. Generate lists of key system attributes:
   ```bash
   # List of installed packages
   dpkg --get-selections > ~/baseline/packages.txt
   
   # List of enabled services
   systemctl list-unit-files --state=enabled > ~/baseline/enabled-services.txt
   
   # List of users and groups
   getent passwd > ~/baseline/passwd.txt
   getent group > ~/baseline/group.txt
   
   # List of SUID/SGID files
   find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > ~/baseline/suid_sgid_files.txt
   
   # List of world-writable files
   find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > ~/baseline/world_writable_files.txt
   ```

### For Windows:
1. Create a clean installation of the same Windows version used in competition
2. Export registry keys for comparison:
   ```powershell
   # Export startup items
   reg export "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" baseline_run.reg
   
   # Export services
   reg export "HKLM\SYSTEM\CurrentControlSet\Services" baseline_services.reg
   
   # Export users
   wmic useraccount list full > baseline_users.txt
   
   # Export groups and members
   net localgroup > baseline_groups.txt
   ```

3. Save baseline configuration settings:
   ```powershell
   # Export firewall rules
   netsh advfirewall export "baseline_firewall.wfw"
   
   # Export scheduled tasks
   schtasks /query /fo LIST > baseline_tasks.txt
   ```

## Using Meld During Competition

### Basic File Comparison:
1. Launch Meld
2. Select "File Comparison" mode
3. Choose your baseline file (left side)
4. Choose the competition system's file (right side)
5. Meld will highlight differences in color:
   - Red: Deleted lines (present in baseline, missing in competition)
   - Green: Added lines (not in baseline, present in competition)
   - Blue: Changed lines (content modified)

### Directory Comparison:
1. Launch Meld
2. Select "Directory Comparison" mode
3. Choose your baseline directory (left side)
4. Choose the competition system's directory (right side)
5. Meld will show different files in color and allow you to drill down

## Practical CyberPatriot Examples

### Example 1: Finding Unauthorized Users
Compare `/etc/passwd` (Linux) or export user lists (Windows) to identify:
- Unauthorized user accounts added by attackers
- Modified UID/GID values (Linux)
- Users added to privileged groups

### Example 2: Identifying Service Changes
Compare service configurations to find:
- New services added by attackers
- Modified service parameters
- Services with weak configurations

### Example 3: Finding Configuration Weaknesses
Compare security configurations to identify:
- Weakened SSH settings
- Disabled security features
- Modified access controls

## Advanced Meld Usage

### Creating Secure Baselines
You can create "hardened" baselines with security improvements already applied. This allows you to:
1. Identify what's different in the competition image
2. Easily apply your hardened configurations
3. Verify the changes match your secure baseline

### Automated Comparison Script
This simple script automates the process of comparing critical files:

```bash
#!/bin/bash
# Automated baseline comparison for Linux

BASELINE_DIR="$HOME/baseline"
OUTPUT_DIR="$HOME/differences"

# Create output directory
mkdir -p $OUTPUT_DIR

# Compare passwd file
meld $BASELINE_DIR/etc/passwd /etc/passwd

# Compare SSH config
meld $BASELINE_DIR/etc/ssh/sshd_config /etc/ssh/sshd_config

# Compare installed packages
dpkg --get-selections > /tmp/current_packages.txt
meld $BASELINE_DIR/packages.txt /tmp/current_packages.txt

# Compare enabled services
systemctl list-unit-files --state=enabled > /tmp/current_services.txt
meld $BASELINE_DIR/enabled-services.txt /tmp/current_services.txt

# Compare SUID/SGID files
find / -type f \( -perm -4000 -o -perm -2000 \) 2>/dev/null > /tmp/current_suid_sgid.txt
meld $BASELINE_DIR/suid_sgid_files.txt /tmp/current_suid_sgid.txt

# Compare world-writable files
find / -type f -perm -o+w 2>/dev/null | grep -v "/proc/" | grep -v "/sys/" > /tmp/current_world_writable.txt
meld $BASELINE_DIR/world_writable_files.txt /tmp/current_world_writable.txt
```

## Integrating Meld into Your Competition Strategy

To use Meld most effectively in CyberPatriot:

1. **Pre-Competition Preparation**:
   - Create clean baselines for each OS you might encounter
   - Create hardened baselines with your security improvements
   - Organize baseline files logically by category
   - Practice using Meld to find intentional differences

2. **During Competition**:
   - Begin with a quick review of the README
   - Immediately run baseline comparisons on critical files
   - Use findings to create a priority list of issues to fix
   - Apply your hardened configurations via Meld
   - Document all differences you find for forensic questions

3. **Post-Competition Analysis**:
   - Note which differences corresponded to vulnerabilities
   - Update your baseline approach for the next round
   - Add any new critical files to your comparison set

## Conclusion

The baselining approach using Meld was a key factor in Akshay's team winning multiple national championships. By incorporating this strategy into your CyberPatriot preparation, you'll be able to:

1. Quickly identify security issues and unauthorized changes
2. Apply consistent, secure configurations to all systems
3. Find subtle vulnerabilities that might be missed with checklists
4. Save valuable time during competition

Remember, the true nature of CyberPatriot is incident response and remediation. Meld helps you excel at both by providing clear visibility into what's changed on a system and helping you apply proper fixes efficiently.
