# Linux Security Scripts

This directory contains Bash scripts for Linux security hardening, auditing, and automation. These scripts help automate common security tasks and provide consistent security implementations for Ubuntu and Linux Mint systems.

## Directory Structure

```
Scripts/
├── Templates/          # Script templates for cadets to modify
├── Examples/           # Example scripts for reference
└── Solutions/          # Solution scripts (mentor access only)
```

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

- **Templates** are incomplete scripts designed to be modified and completed by cadets
- **Examples** are complete, working scripts that demonstrate specific techniques
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
