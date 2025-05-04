# Linux Security Scripts

This directory contains scripts to automate, audit, and harden Linux systems for CyberPatriot training.

## Directory Structure

- **Templates/**  
  Script templates for cadets to modify and use in exercises.  
  *Examples:*  
  - `user_management_template.sh`: Add/remove users, enforce password policies  
  - `service_audit_template.sh`: List and check running services  
  - `firewall_setup_template.sh`: Basic UFW/iptables configuration

- **Examples/**  
  Complete, ready-to-run scripts demonstrating best practices.  
  *Examples:*  
  - `secure_user_add.sh`: Adds users with secure defaults  
  - `audit_services.sh`: Reports on enabled/disabled services  
  - `find_world_writable.sh`: Finds world-writable files

- **Solutions/**  
  Mentor-only solution scripts for exercise scenarios.  
  *Examples:*  
  - `linux_challenge_solution.sh`: Full remediation for a challenge VM  
  - `automated_hardening_solution.sh`: Script that applies all required hardening steps

## How to Use

- Start with a template, adapt it to your scenario, and test in a VM.
- Review example scripts to learn scripting techniques and best practices.
- After attempting an exercise, compare your script to the mentor solution for feedback.

## Tips

- Always test scripts in a safe environment before using in competition.
- Document what each script does and any changes it makes.
- Use scripts to save time and reduce manual errors during CyberPatriot rounds.

*All scripts are unique and tailored for CyberPatriot training. Contributions are welcome!*

## Using These Scripts

Scripts in this directory are meant to be:

1. **Educational**: They demonstrate security concepts and automation techniques
2. **Customizable**: Templates can be modified for specific scenarios
3. **Practical**: They solve real security problems encountered in CyberPatriot

## Script Categories

The scripts are organized into several categories:

### Auditing Scripts
These scripts analyze system security and identify issues:
- System security auditing
- User account auditing
- File permission checks
- Network security analysis

### Hardening Scripts
These scripts implement security controls:
- System hardening
- Service security configuration
- User account security
- Firewall configuration

### Monitoring Scripts
These scripts provide ongoing security checks:
- Log monitoring
- File integrity checks
- Suspicious activity detection
- Security reporting

## Best Practices

When using or modifying these scripts:

1. **Always read and understand scripts before running them**
2. **Test scripts in a controlled environment before using in competition**
3. **Make scripts idempotent (safe to run multiple times)**
4. **Add error handling and logging**
5. **Document all changes made by scripts**
6. **Include clear comments within scripts**

## Templates vs. Examples

- **Templates**: Located in `Templates/`, these are starting points for cadets to build their own scripts.
- **Examples**: Located in `Examples/`, these show completed scripts for reference.
- **Solutions** are reference implementations for mentors (not to be shared with cadets until after exercises)

## Important Note

During CyberPatriot competitions, automated scripts should be used cautiously. While scripting is a valuable skill to learn, the competition emphasizes understanding security concepts. Cadets should know how to perform security tasks manually before automating them.

## Available Scripts

### System Security Audit Script
A comprehensive security scanner that:
- Checks user account security
- Audits system services
- Verifies file permissions
- Examines network security
- Reviews security software configurations
- Searches for suspicious files
- Generates a detailed report with remediation recommendations

### User Account Management Script
Automates user security tasks:
- Lists all user accounts with details
- Identifies suspicious or unauthorized accounts
- Checks for proper password policies
- Verifies group memberships
- Examines sudo access
- Suggests user security improvements

### Service Hardening Script
Secures system services:
- Disables unnecessary services
- Configures secure service parameters
- Sets up secure SSH configuration
- Implements proper service permissions
- Establishes secure defaults

### System Hardening Script
Applies system-wide security controls:
- Configures kernel security parameters
- Sets up secure filesystem mounts
- Implements firewall rules
- Configures security-related software
- Enables system auditing

## Example Scripts

- Add and secure users in bulk
- Audit running services and open ports
- Apply recommended file permissions
- Configure and test UFW firewall rules
- Search for world-writable files and SUID binaries

## Contributing

If you develop additional scripts or improve existing ones:

1. Follow the established format and style
2. Include clear comments and documentation
3. Test thoroughly before submitting
4. Add appropriate error handling
5. Submit a pull request to contribute back to the repository

## Additional Resources

- [Bash Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Linux Security Hardening Guide](https://linuxsecurity.expert/security-tools/linux-security-hardening-guide/)
- [CIS Benchmarks for Linux](https://www.cisecurity.org/benchmark/ubuntu_linux/)
- [SANS Linux Security Checklists](https://www.sans.org/security-resources/posters/securing-linux-cheat-sheet/55/download)
